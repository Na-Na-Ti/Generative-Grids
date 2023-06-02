ArrayList<Grid> grids = new ArrayList<>();

float gridSize = 4;
float gridCountX = width / gridSize;
float gridCountY = height / gridSize;

int cor[][] = {
  {255, 153, 204}, 
  {204, 153, 255}, 
  {255, 255, 0}, 
  {255, 86, 60}, 
  {204, 0, 0}, 
  {0, 128, 255}, 
  {0, 76, 153}, 
  {192, 192, 192}, 
  {255, 255, 255} 
};


void setup() {
  size(1280,720, P3D);
  noStroke();
  
  for (int i = 0; i < gridSize; i++) {
    // Randomly select a grid cell for each Grid object
    float gridX = (int)random(gridCountX) * gridSize;
    float gridY = (int)random(gridCountY) * gridSize;
    grids.add(new Grid(gridX, gridY));
  }
}

void draw() {
  background(255);
  for (Grid grid : grids) {
    grid.draw();
  }
}

class Grid {
 // float rotationDirection; // new variable to control rotation direction
  int grid;
  float angle;
  color c1;
  String shapeType;
  float z = random(150, -600);
  float xInitial = random(width);
  float yInitial = random(height);
  int gridPos = grid/2;
  float rotation;

  Grid(float xInitial, float yInitial) {
    this.xInitial = random(xInitial);
    this.yInitial = random(yInitial);
    this.grid = (int)random(10, 100);
    this.angle = 0;
    int[] colorVals = cor[(int)random(cor.length)];
    this.c1 = color(colorVals[0], colorVals[1], colorVals[2], 0); 
    String[] shapes = {"RECT", "ELLIPSE", "TRIANGLE"};
    this.shapeType = shapes[(int)random(shapes.length)];
   // rotationDirection = random(1) > 0.5 ? 1 : -1;
  }

  void draw() {
    float opacity;
     if (angle <= 180) {
      opacity = map(angle, 0, 180, 0, 255); // Fade in when angle goes from 0 to 180
    } else {
      opacity = map(angle, 180, 360, 255, 0); // Fade out when angle goes from 180 to 360
    }
    c1 = color(red(c1), green(c1), blue(c1), opacity);
    fill(c1);
    
    for (int i = (int)xInitial; i <= width; i+=grid*2) {
      for (int j = (int)yInitial; j <=height; j+=grid*2) {
        pushMatrix();
        translate(i, j, z); 
        //https://processing.org/reference/conditional.html
        drawShape(-grid/2, -grid/2, -radians(angle), -radians(angle));
        drawShape(gridPos, -grid/2, -radians(angle), radians(angle)); 
        drawShape(-grid/2, gridPos, radians(angle), -radians(angle)); 
        drawShape(gridPos, gridPos, radians(angle), radians(angle));
        popMatrix();
      }
    }

    angle += 1; 
    if (angle >= 360) {
      angle = 0;
       //rotation = random(2 * PI);
      //rotation = (random(1) > 0.5) ? -random(TWO_PI) : random(TWO_PI);
      xInitial = random(-width, width);
      yInitial = random(-height, height);
      gridPos = random(1)>0.5?grid/2:-grid/2;
     if (grid <= 5) {
        grid = (int)random(5, 300);
      }
    }
  }

  void drawShape(float transX, float transY, float rotateX, float rotateY) {
    pushMatrix();
    translate(transX + grid / 2, transY + grid / 2);
    rotateX(rotateX);
    rotateY(rotateY);
  //  rotate(rotation);

    switch(shapeType) {
      case "RECT":
        rect(0, 0, grid, grid);
        break;
      case "ELLIPSE":
        ellipse(0, 0, grid, grid);
        break;
      case "TRIANGLE":
        triangle(0, 0, grid, grid/2, grid, grid);
        break;
    }
    popMatrix();
  }
}
