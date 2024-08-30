from components.ai import HostileEnemy
from components.fighter import Fighter
from entity import Actor

player = Actor(
    char="@",
    color=(10, 140, 10),
    name="Player",
    ai_cls=HostileEnemy,
    fighter=Fighter(hp=30, defense=2, power=5),
)

dybot = Actor(
    char="o",
    color=(200, 120, 20),
    name="Dybot",
    ai_cls=HostileEnemy,
    fighter=Fighter(hp=10, defense=0, power=3),
)
modbot = Actor(
    char="M",
    color=(200, 80, 20),
    name="Modbot",
    ai_cls=HostileEnemy,
    fighter=Fighter(hp=16, defense=1, power=4),
)