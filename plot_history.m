#!/bin/octave

f = "output/octave_input.log"
[x y] = textread(f, "%f %f");

offset=datenum('1970', 'yyyy');

t = x/864e2 + offset;

plot(t,y)

datetick("x",0);
