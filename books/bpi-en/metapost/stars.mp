% star.mp
%
% 2011 - Oct -29 Jim Hefferon jhefferon@smcvt .edu Written

outputtemplate :="%j-%c.mps";

numeric line_width_light ;
line_width_light :=0.4pt; % TeX ’s rule width

color rust ;
     rust =(171/255 ,50/255 ,41/255);

def draw_star(expr c) =
  save width, height;
  numeric width, height;
  width=20pt; height=width;
  z0=(.5width ,.5height );           % center
  z1=(x0,height );                   % top corner ; 12 oclock
  z2=((z1-z0) rotated (360/5))+z0;   % mid right corner
  z3=((z1-z0) rotated (2*360/5))+z0; % bot right corner
  z4=((z1-z0) rotated (3*360/5))+z0; % bot left corner
  z5=((z1-z0) rotated (4*360/5))+z0; % mid left corner
  z6=whatever[z1,z3]=whatever[z2,z5]; % mid right of internal pentagon
  z7=whatever[z1,z3]=whatever[z2,z4]; % bot right of internal pentagon
  z8=whatever[z2,z4]=whatever[z3,z5]; % bot of internal pentagon
  z9=whatever[z1,z4]=whatever[z3,z5]; % bot left of internal pentagon
  z10=whatever[z1,z4]=whatever[z2,z5]; % mid left of internal pentagon
  % Outline
  path p;
  p=z1--z6--z2--z7--z3--z8--z4--z9--z5--z10--cycle ;
  fill p withcolor c;
  pickup pencircle scaled line_width_light;
  draw p;
enddef ;

beginfig(0) % muted star
  draw_star(.9[black,white]);
endfig ;

beginfig(4) % exciting star
  draw_star(rust);
endfig ;
end
