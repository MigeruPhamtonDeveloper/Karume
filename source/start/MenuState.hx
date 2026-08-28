package start;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import play.PlayState;
import start.PetalParticle;

class MenuState extends FlxState 
{
    var textTitulo:FlxText;
    var textSubtitulo:FlxText;
    var emisorPetalos:FlxEmitter;
    var camaraJuego:FlxCamera;

    override public function create()
    {
        super.create();

        // 1. Configurar el título principal "Karume"
        textTitulo = new FlxText(0, 0, 0, "Karume", 64);
        textTitulo.screenCenter(); 
        add(textTitulo);

        // 2. Calcular la posición para "PRESS ALPHA" abajo del título
        var posY:Float = textTitulo.y + textTitulo.height + 30;

        // 3. Configurar el subtítulo instruccional
        textSubtitulo = new FlxText(0, posY, FlxG.width, "PRESS ALPHA", 13);
        textSubtitulo.alignment = "center";
        textSubtitulo.color = FlxColor.GRAY;
        add(textSubtitulo);

        // 4. Efecto Tween de parpadeo suave para el "PRESS ALPHA"
        FlxTween.tween(textSubtitulo, {alpha: 0}, 0.8, {type: PINGPONG});

        // 5. Reproducir la música ambiental del menú
        FlxG.sound.playMusic("assets/music/crystal_lake_zone.ogg", 0.7, true);

        // 6. Configuración del sistema de partículas para los pétalos
        emisorPetalos = new FlxEmitter(0, -20, 40);
        emisorPetalos.particleClass = PetalParticle;
        emisorPetalos.width = FlxG.width;

        // Cargamos las partículas desde la hoja de sprites de pétalos
        emisorPetalos.loadParticles("assets/images/petalos/petal1.png", 40, 16, true, false);

        // 7. Hacer que caigan hasta el final de la pantalla (Aumentamos el tiempo de vida de 6 a 10 segundos)
        emisorPetalos.lifespan.set(6, 10);

        // Ajuste de físicas y movimiento aleatorio:
        emisorPetalos.velocity.set(-15, 40, 15, 90); 
        emisorPetalos.angularVelocity.set(-40, 40); 
        emisorPetalos.scale.set(1, 1, 1, 1); 

        // Los insertamos en el fondo (capa 0) para que caigan por detrás de las letras
        insert(0, emisorPetalos);

        // Iniciamos la lluvia constante soltando un pétalo cada 0.1 segundos
        emisorPetalos.start(false, 0.1);

        // 8. Ajustar la camara para el escenario y acercar para que los petalos no se vean pequeños
        
        }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
			// Aca se puede cambiar el estado de la pantalla de inicio al SaveData o al PlayState
		{
			FlxG.switchState(() -> new SaveData());
		}
    }
}