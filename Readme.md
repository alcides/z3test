
# Run on macos / native linux: 
```
bash test.bash
```

# Run on docker:

```
docker run --interactive --tty --rm --volume "$PWD":/wd --workdir "/wd" --entrypoint "/wd/test.bash" "confident/headrest"
```


# Nota

Tive de reordenar os triplos em ambos os modelos, para serem parsed na ordem correcta.

# Conclusions

Both OSes output the same thing for both models (Linux and Mac models).

Linux model or Mac model:
  Java on Linux: UNKNOWN
  Java on Macos: UNKNOWN
  
  Python on Linux: unsat
  Python on Macos: unsat 
  
  
Java and Python libraries both use the same z3 version.

Outputs from mu machine are available in the `outputs` folder.