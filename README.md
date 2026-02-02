# queble-game-jam

## About

The Queble 2026 game jam game using Godot.

## Theme

Primary: "out of place"
Secondary: "timing"

* Goal: clear snow from the roads
* Gameplay: you use unusual units instead of "snow plows", the city and roads are randomly generated, people travel between cities,
you don't control the dragons, feed the dragon, timer, the better you do, the more time you get, you control when people leave the cities,
you have to be careful as people can either get stuck in the snow or be burned by the dragons fire breath

## Licenses

* Images/Fonts/Sounds from Kenney are under Creative Commons Zero (CC0)

## Development Notes

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

## References

* [Queble Game Jam Announcement](https://www.youtube.com/watch?v=MvxyXxrVfIs)
* [Queble Itch 2026 Game Jam Page](https://itch.io/jam/quebles-jam-2026)
