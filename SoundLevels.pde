import ddf.minim.*;

Minim minim;
AudioInput in;
int count = 0;
void setup()
{
  size(1024, 720, P3D);
  
  minim = new Minim(this);

  in = minim.getLineIn(2,512);
  
  textFont(createFont("Arial", 12));
  
}

void draw()
{
  count++;
  if(count>100){count=0;}
  colorMode(HSB, 100);

  fill(count,100,5,25);
  rect(0,0,width,height);

  fill(0,0,0,0);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke(abs(in.left.level())*200,100,100, 10);
    line(i*2, 100 + in.left.get(i)*100, i+1, 100 + in.left.get(i+1)*100);
    rect(300, 300,  floor(in.right.get(i)*200),  floor(in.left.get(i)*200));
    ellipseMode(CENTER);
    ellipse(i*2, 500+in.right.get(i)*i, floor(in.right.get(i+1)*200),  floor(in.left.get(i)*200));
    
    stroke(abs(in.left.level())*100,100,100, 100);
    point(i*2 , (1+in.right.get(i))*300);
    stroke(abs(in.right.level())*100,100,100, 100);
    point(i*2 , (1+in.left.get(i))*300);
  }
  
}