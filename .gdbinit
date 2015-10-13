set auto-load safe-path /

python
import sys
sys.path.insert(0, '/home/gmartins/tools/stlprettyprinter')
from libstdcxx.v6.printers import register_libstdcxx_printers
#register_libstdcxx_printers (None)
end

set p pretty on
set listsize 30
set pagination off

