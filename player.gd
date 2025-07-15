extends Area2D

# 移动速度
@export var speed = 400
# 窗口size
var screen_size


#信号 碰撞
signal hit

# 开始
func start(pos):
	# 重置位置
	position = pos;
	# 开始动画
	$AnimatedSprite2D.animation = "up";
	$AnimatedSprite2D.play();
	#
	set_process(true);
	# 显示player
	show();
	

func _ready():
	# 默认隐藏
	hide();
	# 默认关闭碰撞检测
	$CollisionShape2D.disabled = false;
	# 获取窗口size
	screen_size = get_viewport_rect().size;
	# 
	set_process(false);
	

func _process(delta: float):
	var velocity = Vector2.ZERO; 
	
	# 监听按键
	if Input.is_action_pressed("move_right"):
		velocity.x = 1;
	if Input.is_action_pressed("move_left"):
		velocity.x = -1;
	if Input.is_action_pressed("move_down"):
		velocity.y = 1;
	if Input.is_action_pressed("move_up"):
		velocity.y = -1;
		
	# 上
	if velocity.x == 0 && velocity.y == 0:
		rotation = PI * 0;
	# 上
	if velocity.x == 0 && velocity.y == -1:
		rotation = PI * 0;
	# 右
	if velocity.x == 1 && velocity.y == 0:
		rotation = PI * 0.5;
	# 下
	if velocity.x == 0 && velocity.y == 1:
		rotation = PI * 1;
	# 左
	if velocity.x == -1 && velocity.y == 0:
		rotation = PI * 1.5;
	# 上右
	if velocity.x == 1 && velocity.y == -1:
		rotation = PI * 0.25;
	# 下右
	if velocity.x == 1 && velocity.y == 1:
		rotation = PI * 0.75;
	# 下左
	if velocity.x == -1 && velocity.y == 1:
		rotation = PI * 1.25;
	# 上左
	if velocity.x == -1 && velocity.y == -1:
		rotation = PI * 1.75;
	
	# 移动
	position += velocity.normalized() * delta * speed;
	position = position.clamp(Vector2.ZERO, screen_size);
	

func _on_body_entered(body: Node2D) -> void:
	hide();
	hit.emit();
	# 禁用碰撞检测，避免反复触发hit
	$CollisionShape2D.set_deferred("disabled", true);
