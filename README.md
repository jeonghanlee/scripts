# scripts

* `pdfextract.bash`

This script will be used for splitting a single scan pdf to multiple pdf files with a hard-code prefix name

```
bash pdfextract.bash DOC083023.pdf AL-1635-7629-TIP
```

It will generate 50 split pdf files in the same directory. Sometime, two pages require shuffle due to the page wrong ordering, 
we can use the following commands to ..

```
pdftk 813_AL-1635-7629-TIP.pdf shuffle even odd output test.pdf
mv test.pdf 813_AL-1635-7629-TIP.pdf
```

