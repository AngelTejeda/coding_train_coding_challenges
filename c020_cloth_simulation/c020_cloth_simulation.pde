import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;

Particle[][] particles;
ArrayList<Spring> springs;

VerletPhysics2D physics;
boolean activePhysics = false;

int cols = 30;
int rows = 30;
float sep = 12;
int skip = 8;
float margin = 25;

void setup() {
  size(400, 500);

  // Set gravity
  physics = new VerletPhysics2D();
  Vec2D gravity = new Vec2D(0, 1);
  GravityBehavior2D gb = new GravityBehavior2D(gravity);
  physics.addBehavior(gb);

  // Generate mesh
  generateParticles();
  connectParticles();
}

void draw() {
  background(230, 230, 250);

  fill(0);

  // Title
  textSize(25);
  textAlign(CENTER);
  text("Cloth Simulation", width/2, margin + 10);

  // Show instructions
  textSize(15);
  textAlign(LEFT);

  float base = margin + 20;
  text("→ Press the Space Bar to start the simulation.", margin, base + (20 * 1));
  text("→ Press 'r' to reset.", margin, base + (20 * 2));
  text("→ Click on the points to fix them in place.", margin, base + (20 * 3));

  // Update physics
  if (activePhysics) {
    physics.update();
  }
  // Lock and unlock particles of the mesh
  else {
    for (Particle[] row : particles) {
      for (Particle particle : row) {
        particle.toggleLock();
      }
    }
  }

  // Show springs
  for (Spring spring : springs) {
    spring.show();
  }

  // show particles
  for (Particle[] row : particles) {
    for (Particle particle : row) {
      particle.show();
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    activePhysics = true;
  } else if (key == 'r') {
    generateParticles();
    connectParticles();
    activePhysics = false;
  }
}

void generateParticles() {
  particles = new Particle[rows][cols];

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      float x = margin + (sep * j);
      float y = margin + sep * (i + skip); // skip the first rows

      Particle particle = new Particle(x, y);

      physics.addParticle(particle);
      particles[i][j] = particle;
    }
  }
}

void connectParticles() {
  springs = new ArrayList();

  for (int i=0; i<particles.length; i++) {
    for (int j=0; j<particles[i].length; j++) {
      Particle particle = particles[i][j];

      // Generate right spring
      if (j < cols - 1) {
        Particle right = particles[i][j+1];
        Spring spring = new Spring(particle, right, sep, 0);

        springs.add(spring);
        physics.addSpring(spring);
      }

      // Generate down spring
      if (i < rows - 1) {
        Particle down = particles[i+1][j];
        Spring spring = new Spring(particle, down, sep, 1);

        springs.add(spring);
        physics.addSpring(spring);
      }
    }
  }
}
