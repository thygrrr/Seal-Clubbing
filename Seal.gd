extends KinematicBody2D

export(NodePath) var test

# px/sec
const MOVE_SPEED = 100;
# next position to move to
var target;

func _ready():
	var sprites = [preload("Assets/seal_1.png"), preload("Assets/seal_2.png"), preload("Assets/seal_3.png"), preload("Assets/seal_4.png"), preload("Assets/seal_5.png"), preload("Assets/seal_6.png")]
	$Sprite.texture = sprites[floor(rand_range(0, sprites.size()))]
	target = self.position;

func _process(delta):
	var speed = MOVE_SPEED * delta;
	
	if target.distance_to(self.position) < speed:
		target = newRandomTarget();
	
	var velocity = target - self.position;
	if velocity.length() > speed:
		velocity = velocity.normalized() * speed;
	#move_and_slide(velocity);
	move_and_collide(velocity);
	
func newRandomTarget():
	var Floor = $"../../Floor"
	if Floor:
		var extents = Floor.shape.extents;
		
		var hWidth = extents.x;
		var posx = Floor.position.x + rand_range(- hWidth, hWidth);
		
		var hHeight = extents.y;
		var posy = Floor.position.y + rand_range(- hHeight, hHeight);
		
		return Vector2(posx, posy);
	return Vector2(0, 0)
	