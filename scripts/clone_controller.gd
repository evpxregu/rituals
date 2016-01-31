extends Node2D

# Step 1
# If player Dies call "save()" 

# Step 2
# If loading or waiting call "get()" To get all data

# Step 3
# If player Spawn Call "spawn_clones()" Show Clones

# Step 4
# If player runs Start "play()" in game-loop

# Step 4
# If End-game Call delete()

#Clone Information
var cloneID = 0
var clonePosition = [] # Clone Positions
var cloneReference = []  # Clones (0) CloneID, (1) Clone-Position
var positions = [] # Current Positons
var shoot = [] # Bullet shooting
var lengtIndex = [] # Array Of Clone Index Lengt
var arrayIndex = 0 # Index of current array
var pInstanced = "" # Current Player
var numberOfClones = 0


const LOCATION = "res://cdata/"
const PLAYER_NODE_NAME = "hero"


var test = false
var test1 = false
var test3 = false

#Set Startup Loop
func _ready():
	randomize()
	self.set_process(true)
	pInstanced = get_parent().find_node("hero")

# Create Clones
func _create_clone( ID ):
	var clone = preload("res://scripts/Clone/clone.scn")
	var cloneID = clone.instance()
	var temp = "Clone" + str(ID)
	cloneReference.push_back( temp )
	cloneID.set_name( temp )
	cloneID.set_pos( Vector2(get_parent().find_node("CloneController").get_pos().x, get_parent().find_node("CloneController").get_pos().y))
	get_parent().find_node("CloneController").add_child( cloneID, true )

#Game Loop
func _process( delta ):
	record( ) #Record Current Player
	
	if( test3 == true ):
		play( )

	
	#Suicide
	if(Input.is_action_pressed("ui_cancel")):
		if( test == false ):
			print("Save Clone")
			test = true
			spawn_clones()
			test3 = true
			

	if(Input.is_action_pressed("ui_store")):
		if( test1 == false ):
			test1 = true
			#\save( )			
			get()
			print("Done Reading")


#Save Clones
func save( ):
	var file = File.new( )
	var fname = randi()
	var error = file.open( LOCATION + str(fname) + ".txt", File.WRITE )
	#Write Position to File
	for xy in positions:
		file.store_line( str( xy[0] ) + "|" + str( xy[1] ) )
	file.close( )

#Create Clones
func spawn_clones( ):
	var loop = 0;
	while( loop != numberOfClones ):		
		_create_clone( loop ) # Create Clones
		loop += 1
	

#Play Run Clones
var counter = 0

func play( ):
	var loop = 0
	var minIndex = 0
	while( loop != numberOfClones ):
		var maxIndex = lengtIndex[ loop ] #Max Value
		var temp = minIndex + counter 
		var temp1 = minIndex + maxIndex - 1 
		if( temp < temp1 ):
			var clonePos = clonePosition[ minIndex + counter ]
			set_clone_pos( clonePos, cloneReference[ loop ]  ) # Set Clone Pos
		
		loop += 1
		minIndex = minIndex + maxIndex
	counter += 1

#func shoot( ):
func set_clone_pos( pos, name ):
	get_node(name).set_pos( pos )

#Get Clones
func get( ):
	var dir = Directory.new()
	dir.open(LOCATION)
	dir.list_dir_begin()
	var file = dir.get_next()
	while( file != ""):
		write_array( file )
		file = dir.get_next()
		
	dir.list_dir_end()

# Write Clone Array
func write_array( f ):
	if( str(f) != "." and str(f) != ".."):
		var file = File.new()
		file.open(LOCATION + str( f ), file.READ)
		var lengt = 0
		while(file.eof_reached() == false):
			var read = file.get_line()
			var pos = str(read).split("|", false )
			if( pos.size() != 0 ):
				if( pos[0] != "" and pos[1] != "" ):
					clonePosition.push_back( Vector2( pos[0], pos[1] ) )
					lengt = lengt + 1
		
		lengtIndex.push_back( lengt ) # Total Array size of Clone
		numberOfClones = numberOfClones + 1 #Total Number Of Clones


#Record Playing Clone
func record( ):
	positions.push_back( Vector2( pInstanced.get_pos().x , pInstanced.get_pos().y ) )

#Delete Clones
func delete( ):
	var dir = Directory.new()
	dir.open(LOCATION)
	dir.list_dir_begin()
	var file = dir.get_next()		
	while ( file != "" ):
		var temp = File.new( )
		var error = temp.open( LOCATION + str(file) , File.WRITE )
		temp.store_line( "" )
		temp.close( )
		file = dir.get_next()
		dir.remove( LOCATION + str(file) )		
	dir.list_dir_end()
	