// Bollard Cap with Inner and Outer Rings
// For a pipe with 90mm inner diameter

// Parameters
pipe_inner_diameter = 90; // mm
ring_outer_diameter = 89; // mm to fit inside the pipe (1mm clearance)
ring_height = 15; // mm
wall_thickness = 3; // mm
dome_thickness = 5; // mm - thickness of the dome wall

// Second ring parameters
top_ring_outer_diameter = 110; // mm - larger than the pipe diameter
top_ring_height = 10; // mm

$fn = 200; // resolution for circular objects

// Ring that fits inside the pipe
module inner_ring() {
    difference() {
        cylinder(d=ring_outer_diameter, h=ring_height);
        translate([0, 0, -1])
            cylinder(d=ring_outer_diameter - 2*wall_thickness, h=ring_height + 2);
    }
}

// Second ring with hollow dome that sits on top with larger outer diameter
module top_ring() {
    difference() {
        union() {
            // Top ring
            cylinder(d=top_ring_outer_diameter, h=top_ring_height);
            
            // Dome on top (outer shell)
            translate([0, 0, top_ring_height])
                intersection() {
                    sphere(d=top_ring_outer_diameter);
                    cylinder(d=top_ring_outer_diameter, h=top_ring_outer_diameter/2);
                }
        }
        
        // Hollow out the inside of the top ring
        translate([0, 0, -1])
            cylinder(d=ring_outer_diameter - 2*wall_thickness, h=top_ring_height + 1);
            
        // Hollow out the inside of the dome with the specified wall thickness
        translate([0, 0, top_ring_height])
            intersection() {
                sphere(d=top_ring_outer_diameter - 2*dome_thickness);
                translate([0, 0, -1])
                    cylinder(d=top_ring_outer_diameter, h=top_ring_outer_diameter/2);
            }
    }
}

// Combine the rings
module bollard_cap() {
    inner_ring();
    translate([0, 0, ring_height])
        top_ring();
}

// Render the bollard cap
bollard_cap();