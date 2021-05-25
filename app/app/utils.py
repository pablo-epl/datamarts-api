def get_reverse_sequence(sequence: str) -> str:
    return sequence[::-1]


def get_reverse_complement_sequence(sequence: str) -> str:
    sequence = sequence[::-1]
    sequence = sequence.replace("A", "t").replace("T", "a")
    sequence = sequence.replace("C", "g").replace("G", "c")
    return sequence.upper()
