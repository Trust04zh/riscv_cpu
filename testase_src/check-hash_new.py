import hashlib


def hash256(data: str) -> str:
    seed = bytes.fromhex("323833343837364443464230354342313637413532343935334542")
    sha = hashlib.sha256()
    sha.update(bytes.fromhex(data.rjust(8, "0")) + seed[4:])
    return sha.hexdigest()


if __name__ == "__main__":
    while True:
        print(hash256(input()).upper())
