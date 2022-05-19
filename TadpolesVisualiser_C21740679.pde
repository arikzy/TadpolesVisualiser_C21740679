//A processing program to visualise tadpoles
// By Erik Azev C21740679

public int segmentCount = 8;
public float segmentRadius = 40;
public float tadPoleTopPadding = 40;
public color tadPoleColor;
public int textPadding = 100;

public final String[] kWords = {"Unconditionally", "Personal", "Mask", "Kid", "Off", "Chain", "Bat", "Radar", "John"};

private Tadpole _tadPole;

void setup() {
  size(800, 800);
  generateNewTadpole();
}

void draw() {
  background(0);
  textSize(32);
  _tadPole.update(); 
}

public Gender getRandomGender() {
    return Gender.values()[(int)random(0, 4)];
}

public String generateName() {
  int count = (int)random(1, 6);
  StringBuilder b = new StringBuilder();
  
  for(int i = 0; i < count; i++)
    b.append(kWords[(int)random(kWords.length)] + " ");
  return b.toString();
}

void keyPressed() {
  if(key == ' ')
    generateNewTadpole();
}

void generateNewTadpole() {
  tadPoleColor = color(random(0, 255), random(0, 255), random(0, 255));
  boolean hasLimbs = (int)random(0, 2) == 0;
  _tadPole = new Tadpole(int(random(1, 9)), tadPoleColor, generateName(), hasLimbs, (int)random(0, 10), getRandomGender());
}

public class Tadpole {
  public float legLength = 15;
  public int segmentCount;
  public float segmentRadius = 40;
  public float topPadding = 40;
  public color fillColor;
  public int textPadding = 100;
  public String name;
  public boolean hasLimbs;
  public int eyeCount;
  public Gender gender;
  
  public Tadpole(int segmentCount, color fillColor, String name, boolean hasLimbs, int eyeCount, Gender gender) {
    this.segmentCount = segmentCount;
    this.fillColor = fillColor;
    this.name = name;
    this.hasLimbs = hasLimbs;
    this.eyeCount = eyeCount;
    this.gender = gender;
  }
  
  public void update() {
    pushStyle();
    fill(tadPoleColor);
    float centerX = width / 2f;
    float centerY = (height / 2f) - (((segmentRadius * segmentCount) / 2f) - tadPoleTopPadding);
    float textWidth = textWidth(name) / 2f;
    text(name, centerX - textWidth, centerY - textPadding);
    stroke(tadPoleColor);
    noFill();
    for(int i = 0; i < segmentCount; i++) {
      float y = centerY + segmentRadius * i;
      float rad = segmentRadius / 2f;
      ellipse(centerX, y, segmentRadius, segmentRadius);
      if(hasLimbs && i != 0) {        
        line(centerX + rad, y, centerX + rad + legLength, y);
        line(centerX - rad, y, centerX - rad - legLength, y);
      }
      switch(gender) {
        case M:
          if(i == segmentCount - 1)
          {
            float yEnd = y + rad + 30;
            line(centerX, y + rad, centerX, yEnd);
            ellipse(centerX, yEnd + (rad / 2f), rad, rad);
          }
        break;
        case F:
          if(i == segmentCount - 1)
            ellipse(centerX, y, rad, rad);
        break;
        case H:
            if(i == segmentCount - 1) {
              float yEnd = y + rad + 30;
              line(centerX, y + rad, centerX, yEnd);
              ellipse(centerX, yEnd + (rad / 2f), rad, rad);
              ellipse(centerX, y, rad, rad);
            }
        break;
        default:
          //None
        break;
      }
      float a = PI / eyeCount;
      float eyeRadius = segmentRadius * 2f;
      if(eyeCount != 0 && i == 0) {
        for(float t = 0; t < PI; t += a) {
          float x = centerX  - cos(t) * eyeRadius;
          float dy = y - sin(t) * eyeRadius;
          ellipse(x, dy, rad, rad);
          line(x, dy, centerX - cos(t) * (segmentRadius / 2), y - sin(t) * (segmentRadius / 2));
        }
      }
    }
    popStyle();
  }
}

public enum Gender {
  N,
  M,
  F,
  H
}
