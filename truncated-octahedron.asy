import three;
// settings.render=8;
// settings.prc=false;
size(6cm);

currentprojection = orthographic((3,6,1));

int[][] permutations = {
     {4,3,2,1}
    ,{4,3,1,2}
    ,{4,2,3,1}
    ,{4,2,1,3}
    ,{4,1,2,3}
    ,{4,1,3,2}
    ,{3,4,2,1}
    ,{3,4,1,2}
    ,{3,2,4,1}
    ,{3,2,1,4}
    ,{3,1,2,4}
    ,{3,1,4,2}
    ,{2,3,4,1}
    ,{2,3,1,4}
    ,{2,4,3,1}
    ,{2,4,1,3}
    ,{2,1,4,3}
    ,{2,1,3,4}
    ,{1,3,2,4}
    ,{1,3,4,2}
    ,{1,2,3,4}
    ,{1,2,4,3}
    ,{1,4,2,3}
    ,{1,4,3,2}
};

triple ToCoordinate(int[] p) {
    triple results = (
        sqrt(2.0) / 2.0 * p[0] - sqrt(2.0) / 2.0 * p[1],
        sqrt(6.0) / 6.0 * p[0] + sqrt(6.0) / 6.0 * p[1] - sqrt(2.0/3.0) * p[2],
        sqrt(12.0) / 12.0 * p[0] + sqrt(12.0) / 12.0 * p[1] + sqrt(12.0) / 12.0 * p[2] - sqrt(3.0)/2.0 * p[3]
    );
    return results;
}

material sphereColor = material(diffusepen=black, specularpen=white);
real sphereRadius = 0.10;
void drawAtom(triple center) {
     draw(shift(center)*scale3(sphereRadius)*unitsphere, surfacepen=sphereColor);
}

material cylcolor = material(diffusepen=white);
real cylRadius = 0.05;
void drawRod(triple a, triple b) {
  surface rod = extrude(scale(cylRadius)*unitcircle, axis=length(b-a)*Z);
  triple orthovector = cross(Z, b-a);
  if (length(orthovector) > .01) {
    real angle = aCos(dot(Z, b-a) / length(b-a));
    rod = rotate(angle, orthovector) * rod;
  }
  draw(shift(a)*rod, surfacepen=cylcolor);
}

triple[] coords;

for (int i = 0; i < permutations.length; ++i) {
    coords.push(ToCoordinate(permutations[i]));
    drawAtom(coords[i]);
}

for (int i = 0; i < permutations.length; ++i) {
    for (int j = i+1; j < permutations.length; ++j) {
        int[] diff = permutations[i] - permutations[j];
        int count_n1, count_1, count_0;
        for(int k = 0; k < 4; ++k) {
            if (diff[k] == 0) {
                count_0 = count_0 + 1;
            } else if (diff[k] == 1) {
                count_1 = count_1 + 1;
            } else if (diff[k] == -1) {
                count_n1 = count_n1 + 1;
            }
        }

        if (count_0 != 2 || count_1 != 1 || count_n1 != 1)  continue;
        drawRod(coords[i], coords[j]);
    }
}

triple facecentriod1 = (coords[0] + coords[1] + coords[2] + coords[3] + coords[4] + coords[5]) / 4;
triple facecentriod2 = (coords[9] + coords[10] + coords[17] + coords[20] + coords[18] + coords[13]) / 4;
triple facecentriod3 = (coords[7] + coords[15] + coords[22] + coords[23] + coords[14] + coords[6]) / 4;
triple facecentriod4 = - (facecentriod1 + facecentriod2 + facecentriod3);

draw(O--facecentriod1, red, Arrow3);
draw(O--facecentriod2, blue, Arrow3);
draw(O--facecentriod3, green, Arrow3);
draw(O--facecentriod4, black, Arrow3);
