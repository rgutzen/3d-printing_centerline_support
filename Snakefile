import os
import fnmatch

def changeext(names, filterpat, topat):
    '''
    returns the given list of names filtered for `filterpat` (shell wildcards)
    and filename extensions replaced by `topat`.

    >>> changeext(["a.bar", "b.foo", "c.foo"], "*.bar', '.sdf')
    ['a.sdf']

    '''
    return [name+topat for name in [os.path.splitext(x)[0] for x in fnmatch.filter(names, filterpat)]]


rule all:
    input:
        changeext(os.listdir(os.curdir), '*.scad', '.stl')

rule convert_stl:
    input:
        '{name}.scad',
    output:
        '{name}.stl',
    shell:
        '''
        openscad -o {output} {input}
        '''

rule create_centerline:
    input:
        file = '{filename}.svg',
        script = 'create_centerline.py'
    params:
        closing_dist = 1.,
        separating_dist = 15.,
        min_points = 7,
        tolerance = 0.3
    conda:
        'centerline_env.yaml'
    output:
        '{filename}_centerline.svg'
    shell:
        '''
        python {input.script} --input {input.file} \
                              --output {output} \
                              --closing_dist {params.closing_dist} \
                              --separating_dist {params.separating_dist} \
                              --min_points {params.min_points} \
                              --tolerance {params.tolerance}
        '''
