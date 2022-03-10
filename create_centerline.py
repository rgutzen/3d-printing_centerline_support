from centerline.main import Centerline
from shapely.geometry import Polygon
import svgpathtools
import numpy as np
import copy
import argparse


def path2polygon(path, closing_dist, separating_dist, min_points):
    start_point = 0
    polygon_coords = []

    while start_point < len(path) - 1:
        prev_start_point = copy.copy(start_point)
        points = []

        for linecount, line in enumerate(path[start_point:]):

            # check distance from last polygon
            if len(polygon_coords):
                last_end_pos = polygon_coords[-1][-1]
                new_start_pos = [np.real(line.start), np.imag(line.start)]
                dist_to_last_plygn = np.sqrt(abs(last_end_pos[0] -    \
                                                 new_start_pos[0])**2 \
                                           + abs(last_end_pos[1] -    \
                                                 new_start_pos[1])**2)
            else:
                dist_to_last_plygn = 1000

            if dist_to_last_plygn > separating_dist:
                points += [(np.real(line.start), np.imag(line.start))]
                points += [(np.real(line.end), np.imag(line.end))]

                # check if polygon is closed
                dist_to_start = np.sqrt(abs(points[-1][0] - points[0][0])**2 \
                                      + abs(points[-1][1] - points[0][1])**2)
                if dist_to_start < closing_dist and len(points) > min_points:
                    points += [points[0]]
                    polygon_coords += [points]
                    start_point += linecount
                    # print('loop closed')
                    break

        # close remaining polygon
        if start_point == prev_start_point:
            points += [points[0]]
            polygon_coords += [points]
            break

    print("Structure has {} hole{}".format(len(polygon_coords)-1,
                                           's' if len(polygon_coords)>2 else ''))

    return Polygon(shell=polygon_coords[0], holes=polygon_coords[1:])


def polygon2centerline(polygon, tolerance):
    centerline = Centerline(polygon)
    if tolerance:
        centerline = centerline.simplify(tolerance=tolerance)
    return centerline


def centerline2path(centerline):
    for line in centerline:
        coords = list(line.coords)
        path_seg = svgpathtools.Line(start=coords[0][0] + coords[0][1]*1j,
                                     end  =coords[1][0] + coords[1][1]*1j)
        if 'svgpath' in locals():
            svgpath.append(path_seg)
        else:
            svgpath = svgpathtools.Path(path_seg)
    return svgpath


if __name__ == '__main__':
    CLI = argparse.ArgumentParser()
    CLI.add_argument("--input",           nargs='?', type=str)
    CLI.add_argument("--output",          nargs='?', type=str)
    CLI.add_argument("--closing_dist",    nargs='?', type=float, default=0.1)
    CLI.add_argument("--separating_dist", nargs='?', type=float, default=1.)
    CLI.add_argument("--min_points",      nargs='?', type=int,   default=15)
    CLI.add_argument("--tolerance",       nargs='?', type=float, default=0.)

    args = CLI.parse_args()

    closing_dist = .1
    separating_dist = 15.0
    min_points = 15
    tolerance = 0.2
    input = './M4_Medium_Whole_2/projection.svg'
    output = './M4_Medium_Whole_2/centerline.svg'

    paths, attributes = svgpathtools.svg2paths(input)
    path = paths[0]

    polygon = path2polygon(path=path,
                           closing_dist=closing_dist,
                           separating_dist=separating_dist,
                           min_points=min_points)

    # Check here if polygon represents the structure accurately
    # and all holes were detected.
    polygon

    centerline = polygon2centerline(polygon=polygon,
                                    tolerance=tolerance)

    centerline

    svgpath = centerline2path(centerline)

    svgpathtools.wsvg(svgpath, filename=output)
