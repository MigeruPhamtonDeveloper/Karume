package characters; // Importante: define que está dentro de la carpeta characters

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDirectionFlags;

class Karume extends FlxSprite
{
    // Propiedad para ajustar la velocidad fácilmente desde fuera si lo necesitas
    public var speed:Float = 100;

    public function new(X:Float = 0, Y:Float = 0)
    {
        super(X, Y);

        // 1. Cargamos la hoja de sprites de Karume
        // Asegúrate de que la ruta apunte correctamente a donde guardaste tu SpriteSheet.png
        loadGraphic("assets/images/SpriteSheet.png", true, 32, 48);

        // 2. Registramos las animaciones de la hoja usando los índices de los frames
        // Caminatas (Loop activado)
        animation.add("walk_down", [0, 1, 2, 3, 4, 5, 6, 7, 8], 12, true);
        animation.add("walk_right", [18, 19, 20, 21, 22, 23, 24, 25, 26], 12, true);
        animation.add("walk_up", [27, 28, 29, 30, 31, 32, 33, 34, 35], 12, true);

        // Estados quietos (Idle) usando el primer frame de cada dirección
        animation.add("idle_down", [0], 1, false);
        animation.add("idle_right", [18], 1, false);
        animation.add("idle_up", [27], 1, false);

        // Dirección por defecto al aparecer
        facing = FlxDirectionFlags.DOWN;
    }

    override public function update(elapsed:Float):Void
    {
        // Esto es vital para que las animaciones de HaxeFlixel se actualicen fotograma a fotograma
        super.update(elapsed); 
        
        // Controlamos el movimiento y la animación de Karume
        moveAndAnimate();
    }

    private function moveAndAnimate():Void
    {
        // Reiniciamos la velocidad en cada frame para que no se mueva sola
        velocity.set(0, 0);

        // Mapeo de controles (Teclado)
        var right = FlxG.keys.anyPressed([RIGHT, D]);
        var left = FlxG.keys.anyPressed([LEFT, A]);
        var down = FlxG.keys.anyPressed([DOWN, S]);
        var up = FlxG.keys.anyPressed([UP, W]);

        // Lógica de movimiento, asignación de dirección (facing) y volteo (flipX)
        if (right)
        {
            velocity.x = speed;
            facing = FlxDirectionFlags.RIGHT;
            animation.play("walk_right");
            flipX = false; 
        }
        else if (left)
        {
            velocity.x = -speed;
            facing = FlxDirectionFlags.LEFT;
            animation.play("walk_right"); // Reutiliza la animación derecha
            flipX = true;  // Voltea horizontalmente el sprite
        }
        else if (down)
        {
            velocity.y = speed;
            facing = FlxDirectionFlags.DOWN;
            animation.play("walk_down");
        }
        else if (up)
        {
            velocity.y = -speed;
            facing = FlxDirectionFlags.UP;
            animation.play("walk_up");
        }
        else
        {
            // Si el jugador no presiona nada, se activa el estado Idle correspondiente
            switch (facing)
            {
                case FlxDirectionFlags.RIGHT:
                    animation.play("idle_right");
                    flipX = false;
                case FlxDirectionFlags.LEFT:
                    animation.play("idle_right");
                    flipX = true;
                case FlxDirectionFlags.UP:
                    animation.play("idle_up");
                default:
                    animation.play("idle_down");
            }
        }
    }
}