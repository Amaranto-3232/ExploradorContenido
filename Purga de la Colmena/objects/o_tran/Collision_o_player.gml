// las puertas se bloquean mientras el jefe siga vivo
if(instance_exists(o_boss_warboss)) exit;
if(other.dead) exit;

global.previous_room = room;

room_goto(target_room);
