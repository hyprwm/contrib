from dataclasses import dataclass
from typing import Dict, List, Tuple, Union


@dataclass
class ConfigurationSection:
    @dataclass
    class Event:
        @dataclass
        class Gate:
            set: str
            reset: str
            check: str

        event: str
        match: str
        gate: Union[Gate, None]
        keyword: Union[List[str], None]
        dispatch: Union[List[str], None]

    tokens: Union[List[str], None]
    range: Union[Tuple[int, int, int], None]
    bind: Union[Dict[str, str], None]
    keyword: Union[List[str], None]
    dispatch: Union[List[str], None]
    events: Union[List[Event], None]
