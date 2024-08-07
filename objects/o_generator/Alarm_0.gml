/*
 * Корректируем начальное состояние объекта и активируем его
 */

object_ready = true;

var _first_block = instance_find(o_platform_first, 0);
generator_current.last_position_block.x = _first_block.x;
generator_current.last_position_block.y = _first_block.y;
