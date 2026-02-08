# queble-game-jam

## About

The Queble 2026 game jam game using Godot.

Dragons roam the roads clearing snow with their fire.  Your objective is to
move people between cities while avoiding the dragons otherwise your people will
be eaten.  Your people will move faster on cleared roads rather than snowy roads.
Get as many people as you can moving between the cities before time runs out!

## Theme

* Primary: "out of place"
* Secondary: "timing"

## Play It!

"Dragons Clear the Snow"

Play it directly in the browser here:

[https://firefly2442.itch.io/dragons-clear-the-way](https://firefly2442.itch.io/dragons-clear-the-way)

## Licenses

* Some images and sounds from Kenney are under Creative Commons Zero (CC0)
  * star image
  * fire texture
  * ui and effect sounds

No AI generated art was used.

## Development Notes

Developed and tested with Godot `4.6.0`

### Images

* Developed using [Pixelorama](https://github.com/Orama-Interactive/Pixelorama).
* Color palettes from [Lospec](https://lospec.com).

### Exports

#### Windows

#### Linux

#### Web

Export to `./builds/web/`, call the file `index.html`

Build and run the `Dockerfile`

```shell
docker build -t queble-game-jam:latest .
docker run -p 8080:80 queble-game-jam:latest
```

Browse to [http://localhost:8080/](http://localhost:8080/)

Or just use the built-in remote deploy ability in the Godot editor.

## References

* [Queble Game Jam Announcement](https://www.youtube.com/watch?v=MvxyXxrVfIs)
* [Queble Itch 2026 Game Jam Page](https://itch.io/jam/quebles-jam-2026)
* [Pixelorama Tutorial](https://www.youtube.com/watch?v=6srsqLhGhKk)
