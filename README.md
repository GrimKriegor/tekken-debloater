# tekken-debloater

Enumerates all non-essential usm movie files and replaces them with empty but valid ones


## Usage

```
./tekken-debloater [-s STEAMAPPS_LOCATION] [-v TEKKEN_VERSION] [-p]
```

The `-p` flag creates a release archive with a tree of empty files, which can be used instead of this script


## Savings

At the time of the latest revision, the savings are as follows

| Game     | Size (nominal) | Size (debloated) | Savings |
| -------- | -------------- | ---------------- | ------- |
| TEKKEN 8 | 113GiB         | 67GiB            | 46GiB   |
| TEKKEN 7 | 81GiB          | 57GiB            | 24GiB   |


## Attribution

Big thanks to ToNiO for the help designing this and being PRO and excellent in general
