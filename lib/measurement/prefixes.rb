# coding: utf-8

module Measurement
  PREFIXES = {
    'Y'  => { name: 'yotta', symbol: 'Y',  power: 24  },
    'Z'  => { name: 'zetta', symbol: 'Z',  power: 21  },
    'E'  => { name: 'exa',   symbol: 'E',  power: 18  },
    'P'  => { name: 'peta',  symbol: 'P',  power: 15  },
    'T'  => { name: 'tera',  symbol: 'T',  power: 12  },
    'G'  => { name: 'giga',  symbol: 'G',  power: 9   },
    'M'  => { name: 'mega',  symbol: 'M',  power: 6   },
    'k'  => { name: 'kilo',  symbol: 'k',  power: 3   },
    'h'  => { name: 'hecto', symbol: 'h',  power: 2   },
    'da' => { name: 'deca',  symbol: 'da', power: 1   },
    'd'  => { name: 'deci',  symbol: 'd',  power: -1  },
    'c'  => { name: 'centi', symbol: 'c',  power: -2  },
    'm'  => { name: 'milli', symbol: 'm',  power: -3  },
    'µ'  => { name: 'micro', symbol: 'µ',  power: -6  },
    'n'  => { name: 'nano',  symbol: 'n',  power: -9  },
    'p'  => { name: 'pico',  symbol: 'p',  power: -12 },
    'f'  => { name: 'femto', symbol: 'f',  power: -15 },
    'a'  => { name: 'atto',  symbol: 'a',  power: -18 },
    'z'  => { name: 'zepto', symbol: 'z',  power: -21 },
    'y'  => { name: 'yocto', symbol: 'y',  power: -24 }
  }
end
