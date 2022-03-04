$PBExportHeader$u_scintilla.sru
forward
global type u_scintilla from userobject
end type
type r_1 from rectangle within u_scintilla
end type
end forward

global type u_scintilla from userobject
integer width = 2226
integer height = 1292
long backcolor = 67108864
string text = "none"
event setcursor pbm_enchange
event keydown pbm_keydown
event notify pbm_parentnotify
event resize pbm_size
event ue_command pbm_command
r_1 r_1
end type
global u_scintilla u_scintilla

type prototypes
Private Function Long CreateWindowEx (Long dwExStyle, &
												  String lpClassName, &
												  String lpWindowName, &
												  Long dwStyle, Long lx, &
												  Long ly, Long nWidth, &
												  Long nHeight, Long hWndParent, &
												  Long hMenu, Long hInstance, &
												  Long lpParam)  Library "USER32.dll" Alias For "CreateWindowExA;Ansi"

Private Function Long DestroyWindow(Long wHandle) Library "USER32.dll"
	 
Private Function Long SendMessage (Long hWnd, &
    										  Long msg, Long wp, &
										     Long lp) Library "USER32.dll" Alias For "SendMessageA"

Private Function Long SendMessageString (Long hWnd, &
												     Long msg, Long wp, &
												     REF String lp) Library "USER32.dll" Alias For "SendMessageA;Ansi"
	 
Private Function Long SetWindowPos (Long hWnd, Long m, &
										      Long left, Long top, &
										      Long nwidth, Long nheight, &
										      Long flags) Library "USER32.dll"
												
PUBLIC FUNCTION Long SetParent(Long hWndChild, Long hWndNewParent) LIBRARY 'user32.dll'

PUBLIC Function Long LoadLibrary (String lpLibFileName) Library "Kernel32" Alias For "LoadLibraryA;Ansi"
FUNCTION Long GetSystemDirectory (Ref String lp_buffer, Long uSize) Library "Kernel32.dll" Alias FOR "GetSystemDirectoryA;Ansi"
end prototypes

type variables
Public String is_keywords
Private Boolean ib_enablepopup = TRUE
Private Constant Long WS_CHILD = 1073741824
Private Constant Long WS_VISIBLE = 268435456
Private Constant Long WS_EX_CLIENTEDGE = 512
Private Constant Long WM_NOTIFY = 78


//Scintilla
Private Constant Long  INVALID_POSITION = -1
Private Constant Long  SCN_POSCHANGED = 2019
Private Constant Long  SCI_START = 2000
Private Constant Long  SCI_OPTIONAL_START = 3000
Private Constant Long  SCI_LEXER_START = 4000
Private Constant Long  SCI_ADDTEXT = 2001
Private Constant Long  SCI_ADDSTYLEDTEXT = 2002
Private Constant Long  SCI_INSERTTEXT = 2003
Private Constant Long  SCI_CLEARALL = 2004
Private Constant Long  SCI_CLEARDOCUMENTSTYLE = 2005
Private Constant Long  SCI_GETLENGTH = 2006
Private Constant Long  SCI_GETCHARAT = 2007
Private Constant Long  SCI_GETCURRENTPOS = 2008
Private Constant Long  SCI_GETANCHOR = 2009
Private Constant Long  SCI_GETSTYLEAT = 2010
Private Constant Long  SCI_REDO = 2011
Private Constant Long  SCI_SETUNDOCOLLECTION = 2012
Private Constant Long  SCI_SELECTALL = 2013
Private Constant Long  SCI_SETSAVEPOINT = 2014
Private Constant Long  SCI_GETSTYLEDTEXT = 2015
Private Constant Long  SCI_CANREDO = 2016
Private Constant Long  SCI_MARKERLINEFROMHANDLE = 2017
Private Constant Long  SCI_MARKERDELETEHANDLE = 2018
Private Constant Long  SCI_GETUNDOCOLLECTION = 2019
Private Constant Long  SCWS_INVISIBLE = 0
Private Constant Long  SCWS_VISIBLEALWAYS = 1
Private Constant Long  SCWS_VISIBLEAFTERINDENT = 2
Private Constant Long  SCI_GETVIEWWS = 2020
Private Constant Long  SCI_SETVIEWWS = 2021
Private Constant Long  SCI_POSITIONFROMPOINT = 2022
Private Constant Long  SCI_POSITIONFROMPOINTCLOSE = 2023
Private Constant Long  SCI_GOTOLINE = 2024
Private Constant Long  SCI_GOTOPOS = 2025
Private Constant Long  SCI_SETANCHOR = 2026
Private Constant Long  SCI_GETCURLINE = 2027
Private Constant Long  SCI_GETENDSTYLED = 2028
Private Constant Long  SC_EOL_CRLF = 0
Private Constant Long  SC_EOL_CR = 1
Private Constant Long  SC_EOL_LF = 2
Private Constant Long  SCI_CONVERTEOLS = 2029
Private Constant Long  SCI_GETEOLMODE = 2030
Private Constant Long  SCI_SETEOLMODE = 2031
Private Constant Long  SCI_STARTSTYLING = 2032
Private Constant Long  SCI_SETSTYLING = 2033
Private Constant Long  SCI_GETBUFFEREDDRAW = 2034
Private Constant Long  SCI_SETBUFFEREDDRAW = 2035
Private Constant Long  SCI_SETTABWIDTH = 2036
Private Constant Long  SCI_GETTABWIDTH = 2121
Private Constant Long  SC_CP_UTF8 = 65001
Private Constant Long  SC_CP_DBCS = 1
Private Constant Long  SCI_SETCODEPAGE = 2037
Private Constant Long  SCI_SETUSEPALETTE = 2039
Private Constant Long  MARKER_MAX = 31
Private Constant Long  SC_MARK_CIRCLE = 0
Private Constant Long  SC_MARK_ROUNDRECT = 1
Private Constant Long  SC_MARK_ARROW = 2
Private Constant Long  SC_MARK_SMALLRECT = 3
Private Constant Long  SC_MARK_SHORTARROW = 4
Private Constant Long  SC_MARK_EMPTY = 5
Private Constant Long  SC_MARK_ARROWDOWN = 6
Private Constant Long  SC_MARK_MINUS = 7
Private Constant Long  SC_MARK_PLUS = 8
Private Constant Long  SC_MARK_VLINE = 9
Private Constant Long  SC_MARK_LCORNER = 10
Private Constant Long  SC_MARK_TCORNER = 11
Private Constant Long  SC_MARK_BOXPLUS = 12
Private Constant Long  SC_MARK_BOXPLUSCONNECTED = 13
Private Constant Long  SC_MARK_BOXMINUS = 14
Private Constant Long  SC_MARK_BOXMINUSCONNECTED = 15
Private Constant Long  SC_MARK_LCORNERCURVE = 16
Private Constant Long  SC_MARK_TCORNERCURVE = 17
Private Constant Long  SC_MARK_CIRCLEPLUS = 18
Private Constant Long  SC_MARK_CIRCLEPLUSCONNECTED = 19
Private Constant Long  SC_MARK_CIRCLEMINUS = 20
Private Constant Long  SC_MARK_CIRCLEMINUSCONNECTED = 21
Private Constant Long  SC_MARK_BACKGROUND = 22
Private Constant Long  SC_MARK_DOTDOTDOT = 23
Private Constant Long  SC_MARK_ARROWS = 24
Private Constant Long  SC_MARK_PIXMAP = 25
Private Constant Long  SC_MARK_FULLRECT = 26
Private Constant Long  SC_MARK_CHARACTER = 10000
Private Constant Long  SC_MARKNUM_FOLDEREND = 25
Private Constant Long  SC_MARKNUM_FOLDEROPENMID = 26
Private Constant Long  SC_MARKNUM_FOLDERMIDTAIL = 27
Private Constant Long  SC_MARKNUM_FOLDERTAIL = 28
Private Constant Long  SC_MARKNUM_FOLDERSUB = 29
Private Constant Long  SC_MARKNUM_FOLDER = 30
Private Constant Long  SC_MARKNUM_FOLDEROPEN = 31
//Private Constant Long  SC_MASK_FOLDERS = 0xFE000000
Private Constant Long  SCI_MARKERDEFINE = 2040
Private Constant Long  SCI_MARKERSETFORE = 2041
Private Constant Long  SCI_MARKERSETBACK = 2042
Private Constant Long  SCI_MARKERADD = 2043
Private Constant Long  SCI_MARKERDELETE = 2044
Private Constant Long  SCI_MARKERDELETEALL = 2045
Private Constant Long  SCI_MARKERGET = 2046
Private Constant Long  SCI_MARKERNEXT = 2047
Private Constant Long  SCI_MARKERPREVIOUS = 2048
Private Constant Long  SCI_MARKERDEFINEPIXMAP = 2049
Private Constant Long  SC_MARGIN_SYMBOL = 0
Private Constant Long  SC_MARGIN_NUMBER = 1
Private Constant Long  SCI_SETMARGINTYPEN = 2240
Private Constant Long  SCI_GETMARGINTYPEN = 2241
Private Constant Long  SCI_SETMARGINWIDTHN = 2242
Private Constant Long  SCI_GETMARGINWIDTHN = 2243
Private Constant Long  SCI_SETMARGINMASKN = 2244
Private Constant Long  SCI_GETMARGINMASKN = 2245
Private Constant Long  SCI_SETMARGINSENSITIVEN = 2246
Private Constant Long  SCI_GETMARGINSENSITIVEN = 2247
Private Constant Long  STYLE_DEFAULT = 32
Private Constant Long  STYLE_LINENUMBER = 33
Private Constant Long  STYLE_BRACELIGHT = 34
Private Constant Long  STYLE_BRACEBAD = 35
Private Constant Long  STYLE_CONTROLCHAR = 36
Private Constant Long  STYLE_INDENTGUIDE = 37
Private Constant Long  STYLE_LASTPREDEFINED = 39
Private Constant Long  STYLE_MAX = 127
Private Constant Long  SC_CHARSET_ANSI = 0
Private Constant Long  SC_CHARSET_DEFAULT = 1
Private Constant Long  SC_CHARSET_BALTIC = 186
Private Constant Long  SC_CHARSET_CHINESEBIG5 = 136
Private Constant Long  SC_CHARSET_EASTEUROPE = 238
Private Constant Long  SC_CHARSET_GB2312 = 134
Private Constant Long  SC_CHARSET_GREEK = 161
Private Constant Long  SC_CHARSET_HANGUL = 129
Private Constant Long  SC_CHARSET_MAC = 77
Private Constant Long  SC_CHARSET_OEM = 255
Private Constant Long  SC_CHARSET_RUSSIAN = 204
Private Constant Long  SC_CHARSET_SHIFTJIS = 128
Private Constant Long  SC_CHARSET_SYMBOL = 2
Private Constant Long  SC_CHARSET_TURKISH = 162
Private Constant Long  SC_CHARSET_JOHAB = 130
Private Constant Long  SC_CHARSET_HEBREW = 177
Private Constant Long  SC_CHARSET_ARABIC = 178
Private Constant Long  SC_CHARSET_VIETNAMESE = 163
Private Constant Long  SC_CHARSET_THAI = 222
Private Constant Long  SC_CHARSET_8859_15 = 1000
Private Constant Long  SCI_STYLECLEARALL = 2050
Private Constant Long  SCI_STYLESETFORE = 2051
Private Constant Long  SCI_STYLESETBACK = 2052
Private Constant Long  SCI_STYLESETBOLD = 2053
Private Constant Long  SCI_STYLESETITALIC = 2054
Private Constant Long  SCI_STYLESETSIZE = 2055
Private Constant Long  SCI_STYLESETFONT = 2056
Private Constant Long  SCI_STYLESETEOLFILLED = 2057
Private Constant Long  SCI_STYLERESETDEFAULT = 2058
Private Constant Long  SCI_STYLESETUNDERLINE = 2059
Private Constant Long  SC_CASE_MIXED = 0
Private Constant Long  SC_CASE_UPPER = 1
Private Constant Long  SC_CASE_LOWER = 2
Private Constant Long  SCI_STYLESETCASE = 2060
Private Constant Long  SCI_STYLESETCHARACTERSET = 2066
Private Constant Long  SCI_STYLESETHOTSPOT = 2409
Private Constant Long  SCI_SETSELFORE = 2067
Private Constant Long  SCI_SETSELBACK = 2068
Private Constant Long  SCI_SETCARETFORE = 2069
Private Constant Long  SCI_ASSIGNCMDKEY = 2070
Private Constant Long  SCI_CLEARCMDKEY = 2071
Private Constant Long  SCI_CLEARALLCMDKEYS = 2072
Private Constant Long  SCI_SETSTYLINGEX = 2073
Private Constant Long  SCI_STYLESETVISIBLE = 2074
Private Constant Long  SCI_GETCARETPERIOD = 2075
Private Constant Long  SCI_SETCARETPERIOD = 2076
Private Constant Long  SCI_SETWORDCHARS = 2077
Private Constant Long  SCI_BEGINUNDOACTION = 2078
Private Constant Long  SCI_ENDUNDOACTION = 2079
Private Constant Long  INDIC_MAX = 7
Private Constant Long  INDIC_PLAIN = 0
Private Constant Long  INDIC_SQUIGGLE = 1
Private Constant Long  INDIC_TT = 2
Private Constant Long  INDIC_DIAGONAL = 3
Private Constant Long  INDIC_STRIKE = 4
Private Constant Long  INDIC_HIDDEN = 5
Private Constant Long  INDIC_BOX = 6
//Private Constant Long  INDIC0_MASK = 0x20
//Private Constant Long  INDIC1_MASK = 0x40
//Private Constant Long  INDIC2_MASK = 0x80
//Private Constant Long  INDICS_MASK = 0xE0
Private Constant Long  SCI_INDICSETSTYLE = 2080
Private Constant Long  SCI_INDICGETSTYLE = 2081
Private Constant Long  SCI_INDICSETFORE = 2082
Private Constant Long  SCI_INDICGETFORE = 2083
Private Constant Long  SCI_SETWHITESPACEFORE = 2084
Private Constant Long  SCI_SETWHITESPACEBACK = 2085
Private Constant Long  SCI_SETSTYLEBITS = 2090
Private Constant Long  SCI_GETSTYLEBITS = 2091
Private Constant Long  SCI_SETLINESTATE = 2092
Private Constant Long  SCI_GETLINESTATE = 2093
Private Constant Long  SCI_GETMAXLINESTATE = 2094
Private Constant Long  SCI_GETCARETLINEVISIBLE = 2095
Private Constant Long  SCI_SETCARETLINEVISIBLE = 2096
Private Constant Long  SCI_GETCARETLINEBACK = 2097
Private Constant Long  SCI_SETCARETLINEBACK = 2098
Private Constant Long  SCI_STYLESETCHANGEABLE = 2099
Private Constant Long  SCI_AUTOCSHOW = 2100
Private Constant Long  SCI_AUTOCCANCEL = 2101
Private Constant Long  SCI_AUTOCACTIVE = 2102
Private Constant Long  SCI_AUTOCPOSSTART = 2103
Private Constant Long  SCI_AUTOCCOMPLETE = 2104
Private Constant Long  SCI_AUTOCSTOPS = 2105
Private Constant Long  SCI_AUTOCSETSEPARATOR = 2106
Private Constant Long  SCI_AUTOCGETSEPARATOR = 2107
Private Constant Long  SCI_AUTOCSELECT = 2108
Private Constant Long  SCI_AUTOCSETCANCELATSTART = 2110
Private Constant Long  SCI_AUTOCGETCANCELATSTART = 2111
Private Constant Long  SCI_AUTOCSETFILLUPS = 2112
Private Constant Long  SCI_AUTOCSETCHOOSESINGLE = 2113
Private Constant Long  SCI_AUTOCGETCHOOSESINGLE = 2114
Private Constant Long  SCI_AUTOCSETIGNORECASE = 2115
Private Constant Long  SCI_AUTOCGETIGNORECASE = 2116
Private Constant Long  SCI_USERLISTSHOW = 2117
Private Constant Long  SCI_AUTOCSETAUTOHIDE = 2118
Private Constant Long  SCI_AUTOCGETAUTOHIDE = 2119
Private Constant Long  SCI_AUTOCSETDROPRESTOFWORD = 2270
Private Constant Long  SCI_AUTOCGETDROPRESTOFWORD = 2271
Private Constant Long  SCI_REGISTERIMAGE = 2405
Private Constant Long  SCI_CLEARREGISTEREDIMAGES = 2408
Private Constant Long  SCI_AUTOCGETTYPESEPARATOR = 2285
Private Constant Long  SCI_AUTOCSETTYPESEPARATOR = 2286
Private Constant Long  SCI_AUTOCSETMAXWIDTH = 2208
Private Constant Long  SCI_AUTOCGETMAXWIDTH = 2209
Private Constant Long  SCI_AUTOCSETMAXHEIGHT = 2210
Private Constant Long  SCI_AUTOCGETMAXHEIGHT = 2211
Private Constant Long  SCI_SETINDENT = 2122
Private Constant Long  SCI_GETINDENT = 2123
Private Constant Long  SCI_SETUSETABS = 2124
Private Constant Long  SCI_GETUSETABS = 2125
Private Constant Long  SCI_SETLINEINDENTATION = 2126
Private Constant Long  SCI_GETLINEINDENTATION = 2127
Private Constant Long  SCI_GETLINEINDENTPOSITION = 2128
Private Constant Long  SCI_GETCOLUMN = 2129
Private Constant Long  SCI_SETHSCROLLBAR = 2130
Private Constant Long  SCI_GETHSCROLLBAR = 2131
Private Constant Long  SCI_SETINDENTATIONGUIDES = 2132
Private Constant Long  SCI_GETINDENTATIONGUIDES = 2133
Private Constant Long  SCI_SETHIGHLIGHTGUIDE = 2134
Private Constant Long  SCI_GETHIGHLIGHTGUIDE = 2135
Private Constant Long  SCI_GETLINEENDPOSITION = 2136
Private Constant Long  SCI_GETCODEPAGE = 2137
Private Constant Long  SCI_GETCARETFORE = 2138
Private Constant Long  SCI_GETUSEPALETTE = 2139
Private Constant Long  SCI_GETREADONLY = 2140
Private Constant Long  SCI_SETCURRENTPOS = 2141
Private Constant Long  SCI_SETSELECTIONSTART = 2142
Private Constant Long  SCI_GETSELECTIONSTART = 2143
Private Constant Long  SCI_SETSELECTIONEND = 2144
Private Constant Long  SCI_GETSELECTIONEND = 2145
Private Constant Long  SCI_SETPRINTMAGNIFICATION = 2146
Private Constant Long  SCI_GETPRINTMAGNIFICATION = 2147
Private Constant Long  SC_PRINT_NORMAL = 0
Private Constant Long  SC_PRINT_INVERTLIGHT = 1
Private Constant Long  SC_PRINT_BLACKONWHITE = 2
Private Constant Long  SC_PRINT_COLOURONWHITE = 3
Private Constant Long  SC_PRINT_COLOURONWHITEDEFAULTBG = 4
Private Constant Long  SCI_SETPRINTCOLOURMODE = 2148
Private Constant Long  SCI_GETPRINTCOLOURMODE = 2149
Private Constant Long  SCFIND_WHOLEWORD = 2
Private Constant Long  SCFIND_MATCHCASE = 4
//Private Constant Long  SCFIND_WORDSTART = 0x00100000
//Private Constant Long  SCFIND_REGEXP = 0x00200000
//Private Constant Long  SCFIND_POSIX = 0x00400000
Private Constant Long  SCI_FINDTEXT = 2150
Private Constant Long  SCI_FORMATRANGE = 2151
Private Constant Long  SCI_GETFIRSTVISIBLELINE = 2152
Private Constant Long  SCI_GETLINE = 2153
Private Constant Long  SCI_GETLINECOUNT = 2154
Private Constant Long  SCI_SETMARGINLEFT = 2155
Private Constant Long  SCI_GETMARGINLEFT = 2156
Private Constant Long  SCI_SETMARGINRIGHT = 2157
Private Constant Long  SCI_GETMARGINRIGHT = 2158
Private Constant Long  SCI_GETMODIFY = 2159
Private Constant Long  SCI_SETSEL = 2160
Private Constant Long  SCI_GETSELTEXT = 2161
Private Constant Long  SCI_GETTEXTRANGE = 2162
Private Constant Long  SCI_HIDESELECTION = 2163
Private Constant Long  SCI_POINTXFROMPOSITION = 2164
Private Constant Long  SCI_POINTYFROMPOSITION = 2165
Private Constant Long  SCI_LINEFROMPOSITION = 2166
Private Constant Long  SCI_POSITIONFROMLINE = 2167
Private Constant Long  SCI_LINESCROLL = 2168
Private Constant Long  SCI_SCROLLCARET = 2169
Private Constant Long  SCI_REPLACESEL = 2170
Private Constant Long  SCI_SETREADONLY = 2171
Private Constant Long  SCI_NULL = 2172
Private Constant Long  SCI_CANPASTE = 2173
Private Constant Long  SCI_CANUNDO = 2174
Private Constant Long  SCI_EMPTYUNDOBUFFER = 2175
Private Constant Long  SCI_UNDO = 2176
Private Constant Long  SCI_CUT = 2177
Private Constant Long  SCI_COPY = 2178
Private Constant Long  SCI_PASTE = 2179
Private Constant Long  SCI_CLEAR = 2180
Private Constant Long  SCI_SETTEXT = 2181
Private Constant Long  SCI_GETTEXT = 2182
Private Constant Long  SCI_GETTEXTLENGTH = 2183
Private Constant Long  SCI_GETDIRECTFUNCTION = 2184
Private Constant Long  SCI_GETDIRECTPOINTER = 2185
Private Constant Long  SCI_SETOVERTYPE = 2186
Private Constant Long  SCI_GETOVERTYPE = 2187
Private Constant Long  SCI_SETCARETWIDTH = 2188
Private Constant Long  SCI_GETCARETWIDTH = 2189
Private Constant Long  SCI_SETTARGETSTART = 2190
Private Constant Long  SCI_GETTARGETSTART = 2191
Private Constant Long  SCI_SETTARGETEND = 2192
Private Constant Long  SCI_GETTARGETEND = 2193
Private Constant Long  SCI_REPLACETARGET = 2194
Private Constant Long  SCI_REPLACETARGETRE = 2195
Private Constant Long  SCI_SEARCHINTARGET = 2197
Private Constant Long  SCI_SETSEARCHFLAGS = 2198
Private Constant Long  SCI_GETSEARCHFLAGS = 2199
Private Constant Long  SCI_CALLTIPSHOW = 2200
Private Constant Long  SCI_CALLTIPCANCEL = 2201
Private Constant Long  SCI_CALLTIPACTIVE = 2202
Private Constant Long  SCI_CALLTIPPOSSTART = 2203
Private Constant Long  SCI_CALLTIPSETHLT = 2204
Private Constant Long  SCI_CALLTIPSETBACK = 2205
Private Constant Long  SCI_CALLTIPSETFORE = 2206
Private Constant Long  SCI_CALLTIPSETFOREHLT = 2207
Private Constant Long  SCI_VISIBLEFROMDOCLINE = 2220
Private Constant Long  SCI_DOCLINEFROMVISIBLE = 2221
Private Constant Long  SCI_WRAPCOUNT = 2235
//Private Constant Long  SC_FOLDLEVELBASE = 0x400
//Private Constant Long  SC_FOLDLEVELWHITEFLAG = 0x1000
//Private Constant Long  SC_FOLDLEVELHEADERFLAG = 0x2000
//Private Constant Long  SC_FOLDLEVELBOXHEADERFLAG = 0x4000
//Private Constant Long  SC_FOLDLEVELBOXFOOTERFLAG = 0x8000
//Private Constant Long  SC_FOLDLEVELCONTRACTED = 0x10000
//Private Constant Long  SC_FOLDLEVELUNINDENT = 0x20000
//Private Constant Long  SC_FOLDLEVELNUMBERMASK = 0x0FFF
Private Constant Long  SCI_SETFOLDLEVEL = 2222
Private Constant Long  SCI_GETFOLDLEVEL = 2223
Private Constant Long  SCI_GETLASTCHILD = 2224
Private Constant Long  SCI_GETFOLDPARENT = 2225
Private Constant Long  SCI_SHOWLINES = 2226
Private Constant Long  SCI_HIDELINES = 2227
Private Constant Long  SCI_GETLINEVISIBLE = 2228
Private Constant Long  SCI_SETFOLDEXPANDED = 2229
Private Constant Long  SCI_GETFOLDEXPANDED = 2230
Private Constant Long  SCI_TOGGLEFOLD = 2231
Private Constant Long  SCI_ENSUREVISIBLE = 2232
//Private Constant Long  SC_FOLDFLAG_LINEBEFORE_EXPANDED = 0x0002
//Private Constant Long  SC_FOLDFLAG_LINEBEFORE_CONTRACTED = 0x0004
//Private Constant Long  SC_FOLDFLAG_LINEAFTER_EXPANDED = 0x0008
//Private Constant Long  SC_FOLDFLAG_LINEAFTER_CONTRACTED = 0x0010
//Private Constant Long  SC_FOLDFLAG_LEVELNUMBERS = 0x0040
//Private Constant Long  SC_FOLDFLAG_BOX = 0x0001
Private Constant Long  SCI_SETFOLDFLAGS = 2233
Private Constant Long  SCI_ENSUREVISIBLEENFORCEPOLICY = 2234
Private Constant Long  SCI_SETTABINDENTS = 2260
Private Constant Long  SCI_GETTABINDENTS = 2261
Private Constant Long  SCI_SETBACKSPACEUNINDENTS = 2262
Private Constant Long  SCI_GETBACKSPACEUNINDENTS = 2263
Private Constant Long  SC_TIME_FOREVER = 10000000
Private Constant Long  SCI_SETMOUSEDWELLTIME = 2264
Private Constant Long  SCI_GETMOUSEDWELLTIME = 2265
Private Constant Long  SCI_WORDSTARTPOSITION = 2266
Private Constant Long  SCI_WORDENDPOSITION = 2267
Private Constant Long  SC_WRAP_NONE = 0
Private Constant Long  SC_WRAP_WORD = 1
Private Constant Long  SC_WRAP_CHAR = 2
Private Constant Long  SCI_SETWRAPMODE = 2268
Private Constant Long  SCI_GETWRAPMODE = 2269
//Private Constant Long  SC_WRAPVISUALFLAG_NONE = 0x0000
//Private Constant Long  SC_WRAPVISUALFLAG_END = 0x0001
//Private Constant Long  SC_WRAPVISUALFLAG_START = 0x0002
Private Constant Long  SCI_SETWRAPVISUALFLAGS = 2460
Private Constant Long  SCI_GETWRAPVISUALFLAGS = 2461
//Private Constant Long  SC_WRAPVISUALFLAGLOC_DEFAULT = 0x0000
//Private Constant Long  SC_WRAPVISUALFLAGLOC_END_BY_TEXT = x0001
//Private Constant Long  SC_WRAPVISUALFLAGLOC_START_BY_TEXT = x0002
Private Constant Long  SCI_SETWRAPVISUALFLAGSLOCATION = 2462
Private Constant Long  SCI_GETWRAPVISUALFLAGSLOCATION = 2463
Private Constant Long  SCI_SETWRAPSTARTINDENT = 2464
Private Constant Long  SCI_GETWRAPSTARTINDENT = 2465
Private Constant Long  SC_CACHE_NONE = 0
Private Constant Long  SC_CACHE_CARET = 1
Private Constant Long  SC_CACHE_PAGE = 2
Private Constant Long  SC_CACHE_DOCUMENT = 3
Private Constant Long  SCI_SETLAYOUTCACHE = 2272
Private Constant Long  SCI_GETLAYOUTCACHE = 2273
Private Constant Long  SCI_SETSCROLLWIDTH = 2274
Private Constant Long  SCI_GETSCROLLWIDTH = 2275
Private Constant Long  SCI_TEXTWIDTH = 2276
Private Constant Long  SCI_SETENDATLASTLINE = 2277
Private Constant Long  SCI_GETENDATLASTLINE = 2278
Private Constant Long  SCI_TEXTHEIGHT = 2279
Private Constant Long  SCI_SETVSCROLLBAR = 2280
Private Constant Long  SCI_GETVSCROLLBAR = 2281
Private Constant Long  SCI_APPENDTEXT = 2282
Private Constant Long  SCI_GETTWOPHASEDRAW = 2283
Private Constant Long  SCI_SETTWOPHASEDRAW = 2284
Private Constant Long  SCI_TARGETFROMSELECTION = 2287
Private Constant Long  SCI_LINESJOIN = 2288
Private Constant Long  SCI_LINESSPLIT = 2289
Private Constant Long  SCI_SETFOLDMARGINCOLOUR = 2290
Private Constant Long  SCI_SETFOLDMARGINHICOLOUR = 2291
Private Constant Long  SCI_LINEDOWN = 2300
Private Constant Long  SCI_LINEDOWNEXTEND = 2301
Private Constant Long  SCI_LINEUP = 2302
Private Constant Long  SCI_LINEUPEXTEND = 2303
Private Constant Long  SCI_CHARLEFT = 2304
Private Constant Long  SCI_CHARLEFTEXTEND = 2305
Private Constant Long  SCI_CHARRIGHT = 2306
Private Constant Long  SCI_CHARRIGHTEXTEND = 2307
Private Constant Long  SCI_WORDLEFT = 2308
Private Constant Long  SCI_WORDLEFTEXTEND = 2309
Private Constant Long  SCI_WORDRIGHT = 2310
Private Constant Long  SCI_WORDRIGHTEXTEND = 2311
Private Constant Long  SCI_HOME = 2312
Private Constant Long  SCI_HOMEEXTEND =2313
Private Constant Long  SCI_LINEEND =2314
Private Constant Long  SCI_LINEENDEXTEND =2315
//Private Constant Long  SCI_DOCUMENTSTART 2316
//Private Constant Long  SCI_DOCUMENTSTARTEXTEND 2317
//Private Constant Long  SCI_DOCUMENTEND 2318
//Private Constant Long  SCI_DOCUMENTENDEXTEND 2319
//Private Constant Long  SCI_PAGEUP 2320
//Private Constant Long  SCI_PAGEUPEXTEND 2321
//Private Constant Long  SCI_PAGEDOWN 2322
//Private Constant Long  SCI_PAGEDOWNEXTEND 2323
//Private Constant Long  SCI_EDITTOGGLEOVERTYPE 2324
//Private Constant Long  SCI_CANCEL 2325
//Private Constant Long  SCI_DELETEBACK 2326
//Private Constant Long  SCI_TAB 2327
//Private Constant Long  SCI_BACKTAB 2328
//Private Constant Long  SCI_NEWLINE 2329
//Private Constant Long  SCI_FORMFEED 2330
//Private Constant Long  SCI_VCHOME 2331
//Private Constant Long  SCI_VCHOMEEXTEND 2332
//Private Constant Long  SCI_ZOOMIN 2333
//Private Constant Long  SCI_ZOOMOUT 2334
//Private Constant Long  SCI_DELWORDLEFT 2335
//Private Constant Long  SCI_DELWORDRIGHT 2336
//Private Constant Long  SCI_LINECUT 2337
//Private Constant Long  SCI_LINEDELETE 2338
//Private Constant Long  SCI_LINETRANSPOSE 2339
//Private Constant Long  SCI_LINEDUPLICATE 2404
//Private Constant Long  SCI_LOWERCASE 2340
//Private Constant Long  SCI_UPPERCASE 2341
//Private Constant Long  SCI_LINESCROLLDOWN 2342
//Private Constant Long  SCI_LINESCROLLUP 2343
//Private Constant Long  SCI_DELETEBACKNOTLINE 2344
//Private Constant Long  SCI_HOMEDISPLAY 2345
//Private Constant Long  SCI_HOMEDISPLAYEXTEND 2346
//Private Constant Long  SCI_LINEENDDISPLAY 2347
//Private Constant Long  SCI_LINEENDDISPLAYEXTEND 2348
//Private Constant Long  SCI_HOMEWRAP 2349
//Private Constant Long  SCI_HOMEWRAPEXTEND 2450
//Private Constant Long  SCI_LINEENDWRAP 2451
//Private Constant Long  SCI_LINEENDWRAPEXTEND 2452
//Private Constant Long  SCI_VCHOMEWRAP 2453
//Private Constant Long  SCI_VCHOMEWRAPEXTEND 2454
//Private Constant Long  SCI_LINECOPY 2455
//Private Constant Long  SCI_MOVECARETINSIDEVIEW 2401
//Private Constant Long  SCI_LINELENGTH 2350
//Private Constant Long  SCI_BRACEHIGHLIGHT 2351
//Private Constant Long  SCI_BRACEBADLIGHT 2352
//Private Constant Long  SCI_BRACEMATCH 2353
//Private Constant Long  SCI_GETVIEWEOL 2355
//Private Constant Long  SCI_SETVIEWEOL 2356
//Private Constant Long  SCI_GETDOCPOINTER 2357
//Private Constant Long  SCI_SETDOCPOINTER 2358
//Private Constant Long  SCI_SETMODEVENTMASK 2359
//Private Constant Long  EDGE_NONE 0
//Private Constant Long  EDGE_LINE 1
//Private Constant Long  EDGE_BACKGROUND 2
//Private Constant Long  SCI_GETEDGECOLUMN 2360
//Private Constant Long  SCI_SETEDGECOLUMN 2361
//Private Constant Long  SCI_GETEDGEMODE 2362
//Private Constant Long  SCI_SETEDGEMODE 2363
//Private Constant Long  SCI_GETEDGECOLOUR 2364
Private Constant Long  SCI_SETEDGECOLOUR = 2365
//Private Constant Long  SCI_SEARCHANCHOR 2366
//Private Constant Long  SCI_SEARCHNEXT 2367
//Private Constant Long  SCI_SEARCHPREV 2368
//Private Constant Long  SCI_LINESONSCREEN 2370
Private Constant Long  SCI_USEPOPUP = 2371
//Private Constant Long  SCI_SELECTIONISRECTANGLE 2372
//Private Constant Long  SCI_SETZOOM 2373
//Private Constant Long  SCI_GETZOOM 2374
//Private Constant Long  SCI_CREATEDOCUMENT 2375
//Private Constant Long  SCI_ADDREFDOCUMENT 2376
//Private Constant Long  SCI_RELEASEDOCUMENT 2377
//Private Constant Long  SCI_GETMODEVENTMASK 2378
Private Constant Long  SCI_SETFOCUS = 2380
//Private Constant Long  SCI_GETFOCUS 2381
//Private Constant Long  SCI_SETSTATUS 2382
//Private Constant Long  SCI_GETSTATUS 2383
//Private Constant Long  SCI_SETMOUSEDOWNCAPTURES 2384
//Private Constant Long  SCI_GETMOUSEDOWNCAPTURES 2385
//Private Constant Long  SC_CURSORNORMAL -1
//Private Constant Long  SC_CURSORWAIT 4
//Private Constant Long  SCI_SETCURSOR 2386
//Private Constant Long  SCI_GETCURSOR 2387
//Private Constant Long  SCI_SETCONTROLCHARSYMBOL 2388
//Private Constant Long  SCI_GETCONTROLCHARSYMBOL 2389
//Private Constant Long  SCI_WORDPARTLEFT 2390
//Private Constant Long  SCI_WORDPARTLEFTEXTEND 2391
//Private Constant Long  SCI_WORDPARTRIGHT 2392
//Private Constant Long  SCI_WORDPARTRIGHTEXTEND 2393
//Private Constant Long  VISIBLE_SLOP 0x01
//Private Constant Long  VISIBLE_STRICT 0x04
//Private Constant Long  SCI_SETVISIBLEPOLICY 2394
//Private Constant Long  SCI_DELLINELEFT 2395
//Private Constant Long  SCI_DELLINERIGHT 2396
//Private Constant Long  SCI_SETXOFFSET 2397
//Private Constant Long  SCI_GETXOFFSET 2398
//Private Constant Long  SCI_CHOOSECARETX 2399
//Private Constant Long  SCI_GRABFOCUS 2400
//Private Constant Long  CARET_SLOP 0x01
//Private Constant Long  CARET_STRICT 0x04
//Private Constant Long  CARET_JUMPS 0x10
//Private Constant Long  CARET_EVEN 0x08
//Private Constant Long  SCI_SETXCARETPOLICY 2402
//Private Constant Long  SCI_SETYCARETPOLICY 2403
//Private Constant Long  SCI_SETPRINTWRAPMODE 2406
//Private Constant Long  SCI_GETPRINTWRAPMODE 2407
//Private Constant Long  SCI_SETHOTSPOTACTIVEFORE 2410
//Private Constant Long  SCI_SETHOTSPOTACTIVEBACK 2411
//Private Constant Long  SCI_SETHOTSPOTACTIVEUNDERLINE 2412
//Private Constant Long  SCI_SETHOTSPOTSINGLELINE 2421
//Private Constant Long  SCI_PARADOWN 2413
//Private Constant Long  SCI_PARADOWNEXTEND 2414
//Private Constant Long  SCI_PARAUP 2415
//Private Constant Long  SCI_PARAUPEXTEND 2416
//Private Constant Long  SCI_POSITIONBEFORE 2417
//Private Constant Long  SCI_POSITIONAFTER 2418
//Private Constant Long  SCI_COPYRANGE 2419
//Private Constant Long  SCI_COPYTEXT 2420
//Private Constant Long  SC_SEL_STREAM 0
//Private Constant Long  SC_SEL_RECTANGLE 1
//Private Constant Long  SC_SEL_LINES 2
//Private Constant Long  SCI_SETSELECTIONMODE 2422
//Private Constant Long  SCI_GETSELECTIONMODE 2423
//Private Constant Long  SCI_GETLINESELSTARTPOSITION 2424
//Private Constant Long  SCI_GETLINESELENDPOSITION 2425
//Private Constant Long  SCI_LINEDOWNRECTEXTEND 2426
//Private Constant Long  SCI_LINEUPRECTEXTEND 2427
//Private Constant Long  SCI_CHARLEFTRECTEXTEND 2428
//Private Constant Long  SCI_CHARRIGHTRECTEXTEND 2429
//Private Constant Long  SCI_HOMERECTEXTEND 2430
//Private Constant Long  SCI_VCHOMERECTEXTEND 2431
//Private Constant Long  SCI_LINEENDRECTEXTEND 2432
//Private Constant Long  SCI_PAGEUPRECTEXTEND 2433
//Private Constant Long  SCI_PAGEDOWNRECTEXTEND 2434
//Private Constant Long  SCI_STUTTEREDPAGEUP 2435
//Private Constant Long  SCI_STUTTEREDPAGEUPEXTEND 2436
//Private Constant Long  SCI_STUTTEREDPAGEDOWN 2437
//Private Constant Long  SCI_STUTTEREDPAGEDOWNEXTEND 2438
//Private Constant Long  SCI_WORDLEFTEND 2439
//Private Constant Long  SCI_WORDLEFTENDEXTEND 2440
//Private Constant Long  SCI_WORDRIGHTEND 2441
//Private Constant Long  SCI_WORDRIGHTENDEXTEND 2442
//Private Constant Long  SCI_SETWHITESPACECHARS 2443
//Private Constant Long  SCI_SETCHARSDEFAULT 2444
//Private Constant Long  SCI_AUTOCGETCURRENT 2445
//Private Constant Long  SCI_ALLOCATE 2446
//Private Constant Long  SCI_TARGETASUTF8 2447
//Private Constant Long  SCI_SETLENGTHFORENCODE 2448
//Private Constant Long  SCI_ENCODEDFROMUTF8 2449
//Private Constant Long  SCI_FINDCOLUMN 2456
//Private Constant Long  SCI_GETCARETSTICKY 2457
//Private Constant Long  SCI_SETCARETSTICKY 2458
//Private Constant Long  SCI_TOGGLECARETSTICKY 2459
//Private Constant Long  SCI_STARTRECORD 3001
//Private Constant Long  SCI_STOPRECORD 3002
Private Constant Long  SCI_SETLEXER = 4001
//Private Constant Long  SCI_GETLEXER 4002
//Private Constant Long  SCI_COLOURISE 4003
//Private Constant Long  SCI_SETPROPERTY 4004
//Private Constant Long  KEYWORDSET_MAX 8
Private Constant Long  SCI_SETKEYWORDS = 4005
Private Constant Long  SCI_SETLEXERLANGUAGE = 4006
//Private Constant Long  SCI_LOADLEXERLIBRARY 4007
//Private Constant Long  SCI_GETPROPERTY 4008
//Private Constant Long  SCI_GETPROPERTYEXPANDED 4009
//Private Constant Long  SCI_GETPROPERTYINT 4010
//Private Constant Long  SC_MOD_INSERTTEXT 0x1
//Private Constant Long  SC_MOD_DELETETEXT 0x2
//Private Constant Long  SC_MOD_CHANGESTYLE 0x4
//Private Constant Long  SC_MOD_CHANGEFOLD 0x8
//Private Constant Long  SC_PERFORMED_USER 0x10
//Private Constant Long  SC_PERFORMED_UNDO 0x20
//Private Constant Long  SC_PERFORMED_REDO 0x40
//Private Constant Long  SC_MULTISTEPUNDOREDO 0x80
//Private Constant Long  SC_LASTSTEPINUNDOREDO 0x100
//Private Constant Long  SC_MOD_CHANGEMARKER 0x200
//Private Constant Long  SC_MOD_BEFOREINSERT 0x400
//Private Constant Long  SC_MOD_BEFOREDELETE 0x800
//Private Constant Long  SC_MULTILINEUNDOREDO 0x1000
//Private Constant Long  SC_MODEVENTMASKALL 0x1FFF
//Private Constant Long  SCEN_CHANGE 768
//Private Constant Long  SCEN_SETFOCUS 512
//Private Constant Long  SCEN_KILLFOCUS 256
//Private Constant Long  SCK_DOWN 300
//Private Constant Long  SCK_UP 301
//Private Constant Long  SCK_LEFT 302
//Private Constant Long  SCK_RIGHT 303
//Private Constant Long  SCK_HOME 304
//Private Constant Long  SCK_END 305
//Private Constant Long  SCK_PRIOR 306
//Private Constant Long  SCK_NEXT 307
//Private Constant Long  SCK_DELETE 308
//Private Constant Long  SCK_INSERT 309
//Private Constant Long  SCK_ESCAPE 7
//Private Constant Long  SCK_BACK 8
//Private Constant Long  SCK_TAB 9
//Private Constant Long  SCK_RETURN 13
//Private Constant Long  SCK_ADD 310
//Private Constant Long  SCK_SUBTRACT 311
//Private Constant Long  SCK_DIVIDE 312
//Private Constant Long  SCMOD_SHIFT 1
//Private Constant Long  SCMOD_CTRL 2
//Private Constant Long  SCMOD_ALT 4
//Private Constant Long  SCN_STYLENEEDED 2000
//Private Constant Long  SCN_CHARADDED 2001
Private Constant Long  SCN_SAVEPOINTREACHED = 2002
Private Constant Long  SCN_SAVEPOINTLEFT = 2003
//Private Constant Long  SCN_MODIFYATTEMPTRO 2004
Private Constant Long  SCN_KEY = 2005
//Private Constant Long  SCN_DOUBLECLICK 2006
Private Constant Long  SCN_UPDATEUI = 2007
Private Constant Long  SCN_MODIFIED = 2008
//Private Constant Long  SCN_MACRORECORD 2009
//Private Constant Long  SCN_MARGINCLICK 2010
//Private Constant Long  SCN_NEEDSHOWN 2011
//Private Constant Long  SCN_PAINTED 2013
//Private Constant Long  SCN_USERLISTSELECTION 2014
//Private Constant Long  SCN_URIDROPPED 2015
//Private Constant Long  SCN_DWELLSTART 2016
//Private Constant Long  SCN_DWELLEND 2017
//Private Constant Long  SCN_ZOOM 2018
//Private Constant Long  SCN_HOTSPOTCLICK 2019
//Private Constant Long  SCN_HOTSPOTDOUBLECLICK 2020
//Private Constant Long  SCN_CALLTIPCLICK 2021
//Private Constant Long  SCN_AUTOCSELECTION 2022


//#define SCLEX_CONTAINER 0
//#define SCLEX_NULL 1
//#define SCLEX_PYTHON 2
Private Constant Long SCLEX_CPP = 3
//#define SCLEX_HTML 4
//#define SCLEX_XML 5
//#define SCLEX_PERL 6
Private Constant Long SCLEX_SQL = 7
//#define SCLEX_VB 8
//#define SCLEX_PROPERTIES 9
//#define SCLEX_ERRORLIST 10
//#define SCLEX_MAKEFILE 11
//#define SCLEX_BATCH 12
//#define SCLEX_XCODE 13
//#define SCLEX_LATEX 14
//#define SCLEX_LUA 15
//#define SCLEX_DIFF 16
//#define SCLEX_CONF 17
//#define SCLEX_PASCAL 18
//#define SCLEX_AVE 19
//#define SCLEX_ADA 20
//#define SCLEX_LISP 21
//#define SCLEX_RUBY 22
//#define SCLEX_EIFFEL 23
//#define SCLEX_EIFFELKW 24
//#define SCLEX_TCL 25
//#define SCLEX_NNCRONTAB 26
//#define SCLEX_BULLANT 27
//#define SCLEX_VBSCRIPT 28
//#define SCLEX_BAAN 31
//#define SCLEX_MATLAB 32
//#define SCLEX_SCRIPTOL 33
//#define SCLEX_ASM 34
//#define SCLEX_CPPNOCASE 35
//#define SCLEX_FORTRAN 36
//#define SCLEX_F77 37
//#define SCLEX_CSS 38
//#define SCLEX_POV 39
//#define SCLEX_LOUT 40
//#define SCLEX_ESCRIPT 41
//#define SCLEX_PS 42
//#define SCLEX_NSIS 43
//#define SCLEX_MMIXAL 44
//#define SCLEX_CLW 45
//#define SCLEX_CLWNOCASE 46
//#define SCLEX_LOT 47
//#define SCLEX_YAML 48
//#define SCLEX_TEX 49
//#define SCLEX_METAPOST 50
//#define SCLEX_POWERBASIC 51
//#define SCLEX_FORTH 52
//#define SCLEX_ERLANG 53
//#define SCLEX_OCTAVE 54
//#define SCLEX_MSSQL 55
//#define SCLEX_VERILOG 56
//#define SCLEX_KIX 57
//#define SCLEX_GUI4CLI 58
//#define SCLEX_SPECMAN 59
//#define SCLEX_AU3 60
//#define SCLEX_APDL 61
//#define SCLEX_BASH 62
//#define SCLEX_ASN1 63
//#define SCLEX_VHDL 64
//#define SCLEX_CAML 65
//#define SCLEX_BLITZBASIC 66
//#define SCLEX_PUREBASIC 67
//#define SCLEX_HASKELL 68
//#define SCLEX_PHPSCRIPT 69
//#define SCLEX_TADS3 70
//#define SCLEX_REBOL 71
//#define SCLEX_SMALLTALK 72
//#define SCLEX_FLAGSHIP 73
//#define SCLEX_CSOUND 74
//#define SCLEX_AUTOMATIC 1000
//#define SCE_P_DEFAULT 0
//#define SCE_P_COMMENTLINE 1
//#define SCE_P_NUMBER 2
//#define SCE_P_STRING 3
//#define SCE_P_CHARACTER 4
//#define SCE_P_WORD 5
//#define SCE_P_TRIPLE 6
//#define SCE_P_TRIPLEDOUBLE 7
//#define SCE_P_CLASSNAME 8
//#define SCE_P_DEFNAME 9
//#define SCE_P_OPERATOR 10
//#define SCE_P_IDENTIFIER 11
//#define SCE_P_COMMENTBLOCK 12
//#define SCE_P_STRINGEOL 13
//#define SCE_C_DEFAULT 0
//#define SCE_C_COMMENT 1
//#define SCE_C_COMMENTLINE 2
//#define SCE_C_COMMENTDOC 3
//#define SCE_C_NUMBER 4
//#define SCE_C_WORD 5
//#define SCE_C_STRING 6
//#define SCE_C_CHARACTER 7
//#define SCE_C_UUID 8
//#define SCE_C_PREPROCESSOR 9
//#define SCE_C_OPERATOR 10
//#define SCE_C_IDENTIFIER 11
//#define SCE_C_STRINGEOL 12
//#define SCE_C_VERBATIM 13
//#define SCE_C_REGEX 14
//#define SCE_C_COMMENTLINEDOC 15
//#define SCE_C_WORD2 16
//#define SCE_C_COMMENTDOCKEYWORD 17
//#define SCE_C_COMMENTDOCKEYWORDERROR 18
//#define SCE_C_GLOBALCLASS 19
//#define SCE_H_DEFAULT 0
//#define SCE_H_TAG 1
//#define SCE_H_TAGUNKNOWN 2
//#define SCE_H_ATTRIBUTE 3
//#define SCE_H_ATTRIBUTEUNKNOWN 4
//#define SCE_H_NUMBER 5
//#define SCE_H_DOUBLESTRING 6
//#define SCE_H_SINGLESTRING 7
//#define SCE_H_OTHER 8
//#define SCE_H_COMMENT 9
//#define SCE_H_ENTITY 10
//#define SCE_H_TAGEND 11
//#define SCE_H_XMLSTART 12
//#define SCE_H_XMLEND 13
//#define SCE_H_SCRIPT 14
//#define SCE_H_ASP 15
//#define SCE_H_ASPAT 16
//#define SCE_H_CDATA 17
//#define SCE_H_QUESTION 18
//#define SCE_H_VALUE 19
//#define SCE_H_XCCOMMENT 20
//#define SCE_H_SGML_DEFAULT 21
//#define SCE_H_SGML_COMMAND 22
//#define SCE_H_SGML_1ST_PARAM 23
//#define SCE_H_SGML_DOUBLESTRING 24
//#define SCE_H_SGML_SIMPLESTRING 25
//#define SCE_H_SGML_ERROR 26
//#define SCE_H_SGML_SPECIAL 27
//#define SCE_H_SGML_ENTITY 28
//#define SCE_H_SGML_COMMENT 29
//#define SCE_H_SGML_1ST_PARAM_COMMENT 30
//#define SCE_H_SGML_BLOCK_DEFAULT 31
//#define SCE_HJ_START 40
//#define SCE_HJ_DEFAULT 41
//#define SCE_HJ_COMMENT 42
//#define SCE_HJ_COMMENTLINE 43
//#define SCE_HJ_COMMENTDOC 44
//#define SCE_HJ_NUMBER 45
//#define SCE_HJ_WORD 46
//#define SCE_HJ_KEYWORD 47
//#define SCE_HJ_DOUBLESTRING 48
//#define SCE_HJ_SINGLESTRING 49
//#define SCE_HJ_SYMBOLS 50
//#define SCE_HJ_STRINGEOL 51
//#define SCE_HJ_REGEX 52
//#define SCE_HJA_START 55
//#define SCE_HJA_DEFAULT 56
//#define SCE_HJA_COMMENT 57
//#define SCE_HJA_COMMENTLINE 58
//#define SCE_HJA_COMMENTDOC 59
//#define SCE_HJA_NUMBER 60
//#define SCE_HJA_WORD 61
//#define SCE_HJA_KEYWORD 62
//#define SCE_HJA_DOUBLESTRING 63
//#define SCE_HJA_SINGLESTRING 64
//#define SCE_HJA_SYMBOLS 65
//#define SCE_HJA_STRINGEOL 66
//#define SCE_HJA_REGEX 67
//#define SCE_HB_START 70
//#define SCE_HB_DEFAULT 71
//#define SCE_HB_COMMENTLINE 72
//#define SCE_HB_NUMBER 73
//#define SCE_HB_WORD 74
//#define SCE_HB_STRING 75
//#define SCE_HB_IDENTIFIER 76
//#define SCE_HB_STRINGEOL 77
//#define SCE_HBA_START 80
//#define SCE_HBA_DEFAULT 81
//#define SCE_HBA_COMMENTLINE 82
//#define SCE_HBA_NUMBER 83
//#define SCE_HBA_WORD 84
//#define SCE_HBA_STRING 85
//#define SCE_HBA_IDENTIFIER 86
//#define SCE_HBA_STRINGEOL 87
//#define SCE_HP_START 90
//#define SCE_HP_DEFAULT 91
//#define SCE_HP_COMMENTLINE 92
//#define SCE_HP_NUMBER 93
//#define SCE_HP_STRING 94
//#define SCE_HP_CHARACTER 95
//#define SCE_HP_WORD 96
//#define SCE_HP_TRIPLE 97
//#define SCE_HP_TRIPLEDOUBLE 98
//#define SCE_HP_CLASSNAME 99
//#define SCE_HP_DEFNAME 100
//#define SCE_HP_OPERATOR 101
//#define SCE_HP_IDENTIFIER 102
//#define SCE_HPHP_COMPLEX_VARIABLE 104
//#define SCE_HPA_START 105
//#define SCE_HPA_DEFAULT 106
//#define SCE_HPA_COMMENTLINE 107
//#define SCE_HPA_NUMBER 108
//#define SCE_HPA_STRING 109
//#define SCE_HPA_CHARACTER 110
//#define SCE_HPA_WORD 111
//#define SCE_HPA_TRIPLE 112
//#define SCE_HPA_TRIPLEDOUBLE 113
//#define SCE_HPA_CLASSNAME 114
//#define SCE_HPA_DEFNAME 115
//#define SCE_HPA_OPERATOR 116
//#define SCE_HPA_IDENTIFIER 117
//#define SCE_HPHP_DEFAULT 118
//#define SCE_HPHP_HSTRING 119
//#define SCE_HPHP_SIMPLESTRING 120
//#define SCE_HPHP_WORD 121
//#define SCE_HPHP_NUMBER 122
//#define SCE_HPHP_VARIABLE 123
//#define SCE_HPHP_COMMENT 124
//#define SCE_HPHP_COMMENTLINE 125
//#define SCE_HPHP_HSTRING_VARIABLE 126
//#define SCE_HPHP_OPERATOR 127
//#define SCE_PL_DEFAULT 0
//#define SCE_PL_ERROR 1
//#define SCE_PL_COMMENTLINE 2
//#define SCE_PL_POD 3
//#define SCE_PL_NUMBER 4
//#define SCE_PL_WORD 5
//#define SCE_PL_STRING 6
//#define SCE_PL_CHARACTER 7
//#define SCE_PL_PUNCTUATION 8
//#define SCE_PL_PREPROCESSOR 9
//#define SCE_PL_OPERATOR 10
//#define SCE_PL_IDENTIFIER 11
//#define SCE_PL_SCALAR 12
//#define SCE_PL_ARRAY 13
//#define SCE_PL_HASH 14
//#define SCE_PL_SYMBOLTABLE 15
//#define SCE_PL_REGEX 17
//#define SCE_PL_REGSUBST 18
//#define SCE_PL_LONGQUOTE 19
//#define SCE_PL_BACKTICKS 20
//#define SCE_PL_DATASECTION 21
//#define SCE_PL_HERE_DELIM 22
//#define SCE_PL_HERE_Q 23
//#define SCE_PL_HERE_QQ 24
//#define SCE_PL_HERE_QX 25
//#define SCE_PL_STRING_Q 26
//#define SCE_PL_STRING_QQ 27
//#define SCE_PL_STRING_QX 28
//#define SCE_PL_STRING_QR 29
//#define SCE_PL_STRING_QW 30
//#define SCE_PL_POD_VERB 31
//#define SCE_B_DEFAULT 0
//#define SCE_B_COMMENT 1
//#define SCE_B_NUMBER 2
//#define SCE_B_KEYWORD 3
//#define SCE_B_STRING 4
//#define SCE_B_PREPROCESSOR 5
//#define SCE_B_OPERATOR 6
//#define SCE_B_IDENTIFIER 7
//#define SCE_B_DATE 8
//#define SCE_B_STRINGEOL 9
//#define SCE_B_KEYWORD2 10
//#define SCE_B_KEYWORD3 11
//#define SCE_B_KEYWORD4 12
//#define SCE_B_CONSTANT 13
//#define SCE_B_ASM 14
//#define SCE_B_LABEL 15
//#define SCE_B_ERROR 16
//#define SCE_B_HEXNUMBER 17
//#define SCE_B_BINNUMBER 18
//#define SCE_PROPS_DEFAULT 0
//#define SCE_PROPS_COMMENT 1
//#define SCE_PROPS_SECTION 2
//#define SCE_PROPS_ASSIGNMENT 3
//#define SCE_PROPS_DEFVAL 4
//#define SCE_L_DEFAULT 0
//#define SCE_L_COMMAND 1
//#define SCE_L_TAG 2
//#define SCE_L_MATH 3
//#define SCE_L_COMMENT 4
//#define SCE_LUA_DEFAULT 0
//#define SCE_LUA_COMMENT 1
//#define SCE_LUA_COMMENTLINE 2
//#define SCE_LUA_COMMENTDOC 3
//#define SCE_LUA_NUMBER 4
//#define SCE_LUA_WORD 5
//#define SCE_LUA_STRING 6
//#define SCE_LUA_CHARACTER 7
//#define SCE_LUA_LITERALSTRING 8
//#define SCE_LUA_PREPROCESSOR 9
//#define SCE_LUA_OPERATOR 10
//#define SCE_LUA_IDENTIFIER 11
//#define SCE_LUA_STRINGEOL 12
//#define SCE_LUA_WORD2 13
//#define SCE_LUA_WORD3 14
//#define SCE_LUA_WORD4 15
//#define SCE_LUA_WORD5 16
//#define SCE_LUA_WORD6 17
//#define SCE_LUA_WORD7 18
//#define SCE_LUA_WORD8 19
//#define SCE_ERR_DEFAULT 0
//#define SCE_ERR_PYTHON 1
//#define SCE_ERR_GCC 2
//#define SCE_ERR_MS 3
//#define SCE_ERR_CMD 4
//#define SCE_ERR_BORLAND 5
//#define SCE_ERR_PERL 6
//#define SCE_ERR_NET 7
//#define SCE_ERR_LUA 8
//#define SCE_ERR_CTAG 9
//#define SCE_ERR_DIFF_CHANGED 10
//#define SCE_ERR_DIFF_ADDITION 11
//#define SCE_ERR_DIFF_DELETION 12
//#define SCE_ERR_DIFF_MESSAGE 13
//#define SCE_ERR_PHP 14
//#define SCE_ERR_ELF 15
//#define SCE_ERR_IFC 16
//#define SCE_ERR_IFORT 17
//#define SCE_ERR_ABSF 18
//#define SCE_ERR_TIDY 19
//#define SCE_ERR_JAVA_STACK 20
//#define SCE_BAT_DEFAULT 0
//#define SCE_BAT_COMMENT 1
//#define SCE_BAT_WORD 2
//#define SCE_BAT_LABEL 3
//#define SCE_BAT_HIDE 4
//#define SCE_BAT_COMMAND 5
//#define SCE_BAT_IDENTIFIER 6
//#define SCE_BAT_OPERATOR 7
//#define SCE_MAKE_DEFAULT 0
//#define SCE_MAKE_COMMENT 1
//#define SCE_MAKE_PREPROCESSOR 2
//#define SCE_MAKE_IDENTIFIER 3
//#define SCE_MAKE_OPERATOR 4
//#define SCE_MAKE_TARGET 5
//#define SCE_MAKE_IDEOL 9
//#define SCE_DIFF_DEFAULT 0
//#define SCE_DIFF_COMMENT 1
//#define SCE_DIFF_COMMAND 2
//#define SCE_DIFF_HEADER 3
//#define SCE_DIFF_POSITION 4
//#define SCE_DIFF_DELETED 5
//#define SCE_DIFF_ADDED 6
//#define SCE_CONF_DEFAULT 0
//#define SCE_CONF_COMMENT 1
//#define SCE_CONF_NUMBER 2
//#define SCE_CONF_IDENTIFIER 3
//#define SCE_CONF_EXTENSION 4
//#define SCE_CONF_PARAMETER 5
//#define SCE_CONF_STRING 6
//#define SCE_CONF_OPERATOR 7
//#define SCE_CONF_IP 8
//#define SCE_CONF_DIRECTIVE 9
//#define SCE_AVE_DEFAULT 0
//#define SCE_AVE_COMMENT 1
//#define SCE_AVE_NUMBER 2
//#define SCE_AVE_WORD 3
//#define SCE_AVE_STRING 6
//#define SCE_AVE_ENUM 7
//#define SCE_AVE_STRINGEOL 8
//#define SCE_AVE_IDENTIFIER 9
//#define SCE_AVE_OPERATOR 10
//#define SCE_AVE_WORD1 11
//#define SCE_AVE_WORD2 12
//#define SCE_AVE_WORD3 13
//#define SCE_AVE_WORD4 14
//#define SCE_AVE_WORD5 15
//#define SCE_AVE_WORD6 16
//#define SCE_ADA_DEFAULT 0
//#define SCE_ADA_WORD 1
//#define SCE_ADA_IDENTIFIER 2
//#define SCE_ADA_NUMBER 3
//#define SCE_ADA_DELIMITER 4
//#define SCE_ADA_CHARACTER 5
//#define SCE_ADA_CHARACTEREOL 6
//#define SCE_ADA_STRING 7
//#define SCE_ADA_STRINGEOL 8
//#define SCE_ADA_LABEL 9
//#define SCE_ADA_COMMENTLINE 10
//#define SCE_ADA_ILLEGAL 11
//#define SCE_BAAN_DEFAULT 0
//#define SCE_BAAN_COMMENT 1
//#define SCE_BAAN_COMMENTDOC 2
//#define SCE_BAAN_NUMBER 3
//#define SCE_BAAN_WORD 4
//#define SCE_BAAN_STRING 5
//#define SCE_BAAN_PREPROCESSOR 6
//#define SCE_BAAN_OPERATOR 7
//#define SCE_BAAN_IDENTIFIER 8
//#define SCE_BAAN_STRINGEOL 9
//#define SCE_BAAN_WORD2 10
//#define SCE_LISP_DEFAULT 0
//#define SCE_LISP_COMMENT 1
//#define SCE_LISP_NUMBER 2
//#define SCE_LISP_KEYWORD 3
//#define SCE_LISP_STRING 6
//#define SCE_LISP_STRINGEOL 8
//#define SCE_LISP_IDENTIFIER 9
//#define SCE_LISP_OPERATOR 10
//#define SCE_EIFFEL_DEFAULT 0
//#define SCE_EIFFEL_COMMENTLINE 1
//#define SCE_EIFFEL_NUMBER 2
//#define SCE_EIFFEL_WORD 3
//#define SCE_EIFFEL_STRING 4
//#define SCE_EIFFEL_CHARACTER 5
//#define SCE_EIFFEL_OPERATOR 6
//#define SCE_EIFFEL_IDENTIFIER 7
//#define SCE_EIFFEL_STRINGEOL 8
//#define SCE_NNCRONTAB_DEFAULT 0
//#define SCE_NNCRONTAB_COMMENT 1
//#define SCE_NNCRONTAB_TASK 2
//#define SCE_NNCRONTAB_SECTION 3
//#define SCE_NNCRONTAB_KEYWORD 4
//#define SCE_NNCRONTAB_MODIFIER 5
//#define SCE_NNCRONTAB_ASTERISK 6
//#define SCE_NNCRONTAB_NUMBER 7
//#define SCE_NNCRONTAB_STRING 8
//#define SCE_NNCRONTAB_ENVIRONMENT 9
//#define SCE_NNCRONTAB_IDENTIFIER 10
//#define SCE_FORTH_DEFAULT 0
//#define SCE_FORTH_COMMENT 1
//#define SCE_FORTH_COMMENT_ML 2
//#define SCE_FORTH_IDENTIFIER 3
//#define SCE_FORTH_CONTROL 4
//#define SCE_FORTH_KEYWORD 5
//#define SCE_FORTH_DEFWORD 6
//#define SCE_FORTH_PREWORD1 7
//#define SCE_FORTH_PREWORD2 8
//#define SCE_FORTH_NUMBER 9
//#define SCE_FORTH_STRING 10
//#define SCE_FORTH_LOCALE 11
//#define SCE_MATLAB_DEFAULT 0
//#define SCE_MATLAB_COMMENT 1
//#define SCE_MATLAB_COMMAND 2
//#define SCE_MATLAB_NUMBER 3
//#define SCE_MATLAB_KEYWORD 4
//#define SCE_MATLAB_STRING 5
//#define SCE_MATLAB_OPERATOR 6
//#define SCE_MATLAB_IDENTIFIER 7
//#define SCE_MATLAB_DOUBLEQUOTESTRING 8
//#define SCE_SCRIPTOL_DEFAULT 0
//#define SCE_SCRIPTOL_WHITE 1
//#define SCE_SCRIPTOL_COMMENTLINE 2
//#define SCE_SCRIPTOL_PERSISTENT 3
//#define SCE_SCRIPTOL_CSTYLE 4
//#define SCE_SCRIPTOL_COMMENTBLOCK 5
//#define SCE_SCRIPTOL_NUMBER 6
//#define SCE_SCRIPTOL_STRING 7
//#define SCE_SCRIPTOL_CHARACTER 8
//#define SCE_SCRIPTOL_STRINGEOL 9
//#define SCE_SCRIPTOL_KEYWORD 10
//#define SCE_SCRIPTOL_OPERATOR 11
//#define SCE_SCRIPTOL_IDENTIFIER 12
//#define SCE_SCRIPTOL_TRIPLE 13
//#define SCE_SCRIPTOL_CLASSNAME 14
//#define SCE_SCRIPTOL_PREPROCESSOR 15
//#define SCE_ASM_DEFAULT 0
//#define SCE_ASM_COMMENT 1
//#define SCE_ASM_NUMBER 2
//#define SCE_ASM_STRING 3
//#define SCE_ASM_OPERATOR 4
//#define SCE_ASM_IDENTIFIER 5
//#define SCE_ASM_CPUINSTRUCTION 6
//#define SCE_ASM_MATHINSTRUCTION 7
//#define SCE_ASM_REGISTER 8
//#define SCE_ASM_DIRECTIVE 9
//#define SCE_ASM_DIRECTIVEOPERAND 10
//#define SCE_ASM_COMMENTBLOCK 11
//#define SCE_ASM_CHARACTER 12
//#define SCE_ASM_STRINGEOL 13
//#define SCE_ASM_EXTINSTRUCTION 14
//#define SCE_F_DEFAULT 0
//#define SCE_F_COMMENT 1
//#define SCE_F_NUMBER 2
//#define SCE_F_STRING1 3
//#define SCE_F_STRING2 4
//#define SCE_F_STRINGEOL 5
//#define SCE_F_OPERATOR 6
//#define SCE_F_IDENTIFIER 7
//#define SCE_F_WORD 8
//#define SCE_F_WORD2 9
//#define SCE_F_WORD3 10
//#define SCE_F_PREPROCESSOR 11
//#define SCE_F_OPERATOR2 12
//#define SCE_F_LABEL 13
//#define SCE_F_CONTINUATION 14
//#define SCE_CSS_DEFAULT 0
//#define SCE_CSS_TAG 1
//#define SCE_CSS_CLASS 2
//#define SCE_CSS_PSEUDOCLASS 3
//#define SCE_CSS_UNKNOWN_PSEUDOCLASS 4
//#define SCE_CSS_OPERATOR 5
//#define SCE_CSS_IDENTIFIER 6
//#define SCE_CSS_UNKNOWN_IDENTIFIER 7
//#define SCE_CSS_VALUE 8
//#define SCE_CSS_COMMENT 9
//#define SCE_CSS_ID 10
//#define SCE_CSS_IMPORTANT 11
//#define SCE_CSS_DIRECTIVE 12
//#define SCE_CSS_DOUBLESTRING 13
//#define SCE_CSS_SINGLESTRING 14
//#define SCE_CSS_IDENTIFIER2 15
//#define SCE_CSS_ATTRIBUTE 16
//#define SCE_POV_DEFAULT 0
//#define SCE_POV_COMMENT 1
//#define SCE_POV_COMMENTLINE 2
//#define SCE_POV_NUMBER 3
//#define SCE_POV_OPERATOR 4
//#define SCE_POV_IDENTIFIER 5
//#define SCE_POV_STRING 6
//#define SCE_POV_STRINGEOL 7
//#define SCE_POV_DIRECTIVE 8
//#define SCE_POV_BADDIRECTIVE 9
//#define SCE_POV_WORD2 10
//#define SCE_POV_WORD3 11
//#define SCE_POV_WORD4 12
//#define SCE_POV_WORD5 13
//#define SCE_POV_WORD6 14
//#define SCE_POV_WORD7 15
//#define SCE_POV_WORD8 16
//#define SCE_LOUT_DEFAULT 0
//#define SCE_LOUT_COMMENT 1
//#define SCE_LOUT_NUMBER 2
//#define SCE_LOUT_WORD 3
//#define SCE_LOUT_WORD2 4
//#define SCE_LOUT_WORD3 5
//#define SCE_LOUT_WORD4 6
//#define SCE_LOUT_STRING 7
//#define SCE_LOUT_OPERATOR 8
//#define SCE_LOUT_IDENTIFIER 9
//#define SCE_LOUT_STRINGEOL 10
//#define SCE_ESCRIPT_DEFAULT 0
//#define SCE_ESCRIPT_COMMENT 1
//#define SCE_ESCRIPT_COMMENTLINE 2
//#define SCE_ESCRIPT_COMMENTDOC 3
//#define SCE_ESCRIPT_NUMBER 4
//#define SCE_ESCRIPT_WORD 5
//#define SCE_ESCRIPT_STRING 6
//#define SCE_ESCRIPT_OPERATOR 7
//#define SCE_ESCRIPT_IDENTIFIER 8
//#define SCE_ESCRIPT_BRACE 9
//#define SCE_ESCRIPT_WORD2 10
//#define SCE_ESCRIPT_WORD3 11
//#define SCE_PS_DEFAULT 0
//#define SCE_PS_COMMENT 1
//#define SCE_PS_DSC_COMMENT 2
//#define SCE_PS_DSC_VALUE 3
//#define SCE_PS_NUMBER 4
//#define SCE_PS_NAME 5
//#define SCE_PS_KEYWORD 6
//#define SCE_PS_LITERAL 7
//#define SCE_PS_IMMEVAL 8
//#define SCE_PS_PAREN_ARRAY 9
//#define SCE_PS_PAREN_DICT 10
//#define SCE_PS_PAREN_PROC 11
//#define SCE_PS_TEXT 12
//#define SCE_PS_HEXSTRING 13
//#define SCE_PS_BASE85STRING 14
//#define SCE_PS_BADSTRINGCHAR 15
//#define SCE_NSIS_DEFAULT 0
//#define SCE_NSIS_COMMENT 1
//#define SCE_NSIS_STRINGDQ 2
//#define SCE_NSIS_STRINGLQ 3
//#define SCE_NSIS_STRINGRQ 4
//#define SCE_NSIS_FUNCTION 5
//#define SCE_NSIS_VARIABLE 6
//#define SCE_NSIS_LABEL 7
//#define SCE_NSIS_USERDEFINED 8
//#define SCE_NSIS_SECTIONDEF 9
//#define SCE_NSIS_SUBSECTIONDEF 10
//#define SCE_NSIS_IFDEFINEDEF 11
//#define SCE_NSIS_MACRODEF 12
//#define SCE_NSIS_STRINGVAR 13
//#define SCE_NSIS_NUMBER 14
//#define SCE_NSIS_SECTIONGROUP 15
//#define SCE_NSIS_PAGEEX 16
//#define SCE_NSIS_FUNCTIONDEF 17
//#define SCE_NSIS_COMMENTBOX 18
//#define SCE_MMIXAL_LEADWS 0
//#define SCE_MMIXAL_COMMENT 1
//#define SCE_MMIXAL_LABEL 2
//#define SCE_MMIXAL_OPCODE 3
//#define SCE_MMIXAL_OPCODE_PRE 4
//#define SCE_MMIXAL_OPCODE_VALID 5
//#define SCE_MMIXAL_OPCODE_UNKNOWN 6
//#define SCE_MMIXAL_OPCODE_POST 7
//#define SCE_MMIXAL_OPERANDS 8
//#define SCE_MMIXAL_NUMBER 9
//#define SCE_MMIXAL_REF 10
//#define SCE_MMIXAL_CHAR 11
//#define SCE_MMIXAL_STRING 12
//#define SCE_MMIXAL_REGISTER 13
//#define SCE_MMIXAL_HEX 14
//#define SCE_MMIXAL_OPERATOR 15
//#define SCE_MMIXAL_SYMBOL 16
//#define SCE_MMIXAL_INCLUDE 17
//#define SCE_CLW_DEFAULT 0
//#define SCE_CLW_LABEL 1
//#define SCE_CLW_COMMENT 2
//#define SCE_CLW_STRING 3
//#define SCE_CLW_USER_IDENTIFIER 4
//#define SCE_CLW_INTEGER_CONSTANT 5
//#define SCE_CLW_REAL_CONSTANT 6
//#define SCE_CLW_PICTURE_STRING 7
//#define SCE_CLW_KEYWORD 8
//#define SCE_CLW_COMPILER_DIRECTIVE 9
//#define SCE_CLW_RUNTIME_EXPRESSIONS 10
//#define SCE_CLW_BUILTIN_PROCEDURES_FUNCTION 11
//#define SCE_CLW_STRUCTURE_DATA_TYPE 12
//#define SCE_CLW_ATTRIBUTE 13
//#define SCE_CLW_STANDARD_EQUATE 14
//#define SCE_CLW_ERROR 15
//#define SCE_CLW_DEPRECATED 16
//#define SCE_LOT_DEFAULT 0
//#define SCE_LOT_HEADER 1
//#define SCE_LOT_BREAK 2
//#define SCE_LOT_SET 3
//#define SCE_LOT_PASS 4
//#define SCE_LOT_FAIL 5
//#define SCE_LOT_ABORT 6
//#define SCE_YAML_DEFAULT 0
//#define SCE_YAML_COMMENT 1
//#define SCE_YAML_IDENTIFIER 2
//#define SCE_YAML_KEYWORD 3
//#define SCE_YAML_NUMBER 4
//#define SCE_YAML_REFERENCE 5
//#define SCE_YAML_DOCUMENT 6
//#define SCE_YAML_TEXT 7
//#define SCE_YAML_ERROR 8
//#define SCE_TEX_DEFAULT 0
//#define SCE_TEX_SPECIAL 1
//#define SCE_TEX_GROUP 2
//#define SCE_TEX_SYMBOL 3
//#define SCE_TEX_COMMAND 4
//#define SCE_TEX_TEXT 5
//#define SCE_METAPOST_DEFAULT 0
//#define SCE_METAPOST_SPECIAL 1
//#define SCE_METAPOST_GROUP 2
//#define SCE_METAPOST_SYMBOL 3
//#define SCE_METAPOST_COMMAND 4
//#define SCE_METAPOST_TEXT 5
//#define SCE_METAPOST_EXTRA 6
//#define SCE_ERLANG_DEFAULT 0
//#define SCE_ERLANG_COMMENT 1
//#define SCE_ERLANG_VARIABLE 2
//#define SCE_ERLANG_NUMBER 3
//#define SCE_ERLANG_KEYWORD 4
//#define SCE_ERLANG_STRING 5
//#define SCE_ERLANG_OPERATOR 6
//#define SCE_ERLANG_ATOM 7
//#define SCE_ERLANG_FUNCTION_NAME 8
//#define SCE_ERLANG_CHARACTER 9
//#define SCE_ERLANG_MACRO 10
//#define SCE_ERLANG_RECORD 11
//#define SCE_ERLANG_SEPARATOR 12
//#define SCE_ERLANG_NODE_NAME 13
//#define SCE_ERLANG_UNKNOWN 31
//#define SCE_MSSQL_DEFAULT 0
//#define SCE_MSSQL_COMMENT 1
//#define SCE_MSSQL_LINE_COMMENT 2
//#define SCE_MSSQL_NUMBER 3
//#define SCE_MSSQL_STRING 4
//#define SCE_MSSQL_OPERATOR 5
//#define SCE_MSSQL_IDENTIFIER 6
//#define SCE_MSSQL_VARIABLE 7
//#define SCE_MSSQL_COLUMN_NAME 8
//#define SCE_MSSQL_STATEMENT 9
//#define SCE_MSSQL_DATATYPE 10
//#define SCE_MSSQL_SYSTABLE 11
//#define SCE_MSSQL_GLOBAL_VARIABLE 12
//#define SCE_MSSQL_FUNCTION 13
//#define SCE_MSSQL_STORED_PROCEDURE 14
//#define SCE_MSSQL_DEFAULT_PREF_DATATYPE 15
//#define SCE_MSSQL_COLUMN_NAME_2 16
//#define SCE_V_DEFAULT 0
//#define SCE_V_COMMENT 1
//#define SCE_V_COMMENTLINE 2
//#define SCE_V_COMMENTLINEBANG 3
//#define SCE_V_NUMBER 4
//#define SCE_V_WORD 5
//#define SCE_V_STRING 6
//#define SCE_V_WORD2 7
//#define SCE_V_WORD3 8
//#define SCE_V_PREPROCESSOR 9
//#define SCE_V_OPERATOR 10
//#define SCE_V_IDENTIFIER 11
//#define SCE_V_STRINGEOL 12
//#define SCE_V_USER 19
//#define SCE_KIX_DEFAULT 0
//#define SCE_KIX_COMMENT 1
//#define SCE_KIX_STRING1 2
//#define SCE_KIX_STRING2 3
//#define SCE_KIX_NUMBER 4
//#define SCE_KIX_VAR 5
//#define SCE_KIX_MACRO 6
//#define SCE_KIX_KEYWORD 7
//#define SCE_KIX_FUNCTIONS 8
//#define SCE_KIX_OPERATOR 9
//#define SCE_KIX_IDENTIFIER 31
//#define SCE_GC_DEFAULT 0
//#define SCE_GC_COMMENTLINE 1
//#define SCE_GC_COMMENTBLOCK 2
//#define SCE_GC_GLOBAL 3
//#define SCE_GC_EVENT 4
//#define SCE_GC_ATTRIBUTE 5
//#define SCE_GC_CONTROL 6
//#define SCE_GC_COMMAND 7
//#define SCE_GC_STRING 8
//#define SCE_GC_OPERATOR 9
//#define SCE_SN_DEFAULT 0
//#define SCE_SN_CODE 1
//#define SCE_SN_COMMENTLINE 2
//#define SCE_SN_COMMENTLINEBANG 3
//#define SCE_SN_NUMBER 4
//#define SCE_SN_WORD 5
//#define SCE_SN_STRING 6
//#define SCE_SN_WORD2 7
//#define SCE_SN_WORD3 8
//#define SCE_SN_PREPROCESSOR 9
//#define SCE_SN_OPERATOR 10
//#define SCE_SN_IDENTIFIER 11
//#define SCE_SN_STRINGEOL 12
//#define SCE_SN_REGEXTAG 13
//#define SCE_SN_SIGNAL 14
//#define SCE_SN_USER 19
//#define SCE_AU3_DEFAULT 0
//#define SCE_AU3_COMMENT 1
//#define SCE_AU3_COMMENTBLOCK 2
//#define SCE_AU3_NUMBER 3
//#define SCE_AU3_FUNCTION 4
//#define SCE_AU3_KEYWORD 5
//#define SCE_AU3_MACRO 6
//#define SCE_AU3_STRING 7
//#define SCE_AU3_OPERATOR 8
//#define SCE_AU3_VARIABLE 9
//#define SCE_AU3_SENT 10
//#define SCE_AU3_PREPROCESSOR 11
//#define SCE_AU3_SPECIAL 12
//#define SCE_AU3_EXPAND 13
//#define SCE_APDL_DEFAULT 0
//#define SCE_APDL_COMMENT 1
//#define SCE_APDL_COMMENTBLOCK 2
//#define SCE_APDL_NUMBER 3
//#define SCE_APDL_STRING 4
//#define SCE_APDL_OPERATOR 5
//#define SCE_APDL_WORD 6
//#define SCE_APDL_PROCESSOR 7
//#define SCE_APDL_COMMAND 8
//#define SCE_APDL_SLASHCOMMAND 9
//#define SCE_APDL_STARCOMMAND 10
//#define SCE_APDL_ARGUMENT 11
//#define SCE_APDL_FUNCTION 12
//#define SCE_SH_DEFAULT 0
//#define SCE_SH_ERROR 1
//#define SCE_SH_COMMENTLINE 2
//#define SCE_SH_NUMBER 3
//#define SCE_SH_WORD 4
//#define SCE_SH_STRING 5
//#define SCE_SH_CHARACTER 6
//#define SCE_SH_OPERATOR 7
//#define SCE_SH_IDENTIFIER 8
//#define SCE_SH_SCALAR 9
//#define SCE_SH_PARAM 10
//#define SCE_SH_BACKTICKS 11
//#define SCE_SH_HERE_DELIM 12
//#define SCE_SH_HERE_Q 13
//#define SCE_ASN1_DEFAULT 0
//#define SCE_ASN1_COMMENT 1
//#define SCE_ASN1_IDENTIFIER 2
//#define SCE_ASN1_STRING 3
//#define SCE_ASN1_OID 4
//#define SCE_ASN1_SCALAR 5
//#define SCE_ASN1_KEYWORD 6
//#define SCE_ASN1_ATTRIBUTE 7
//#define SCE_ASN1_DESCRIPTOR 8
//#define SCE_ASN1_TYPE 9
//#define SCE_ASN1_OPERATOR 10
//#define SCE_VHDL_DEFAULT 0
//#define SCE_VHDL_COMMENT 1
//#define SCE_VHDL_COMMENTLINEBANG 2
//#define SCE_VHDL_NUMBER 3
//#define SCE_VHDL_STRING 4
//#define SCE_VHDL_OPERATOR 5
//#define SCE_VHDL_IDENTIFIER 6
//#define SCE_VHDL_STRINGEOL 7
//#define SCE_VHDL_KEYWORD 8
//#define SCE_VHDL_STDOPERATOR 9
//#define SCE_VHDL_ATTRIBUTE 10
//#define SCE_VHDL_STDFUNCTION 11
//#define SCE_VHDL_STDPACKAGE 12
//#define SCE_VHDL_STDTYPE 13
//#define SCE_VHDL_USERWORD 14
//#define SCE_CAML_DEFAULT 0
//#define SCE_CAML_IDENTIFIER 1
//#define SCE_CAML_TAGNAME 2
//#define SCE_CAML_KEYWORD 3
//#define SCE_CAML_KEYWORD2 4
//#define SCE_CAML_LINENUM 5
//#define SCE_CAML_OPERATOR 6
//#define SCE_CAML_NUMBER 7
//#define SCE_CAML_CHAR 8
//#define SCE_CAML_STRING 9
//#define SCE_CAML_COMMENT 10
//#define SCE_CAML_COMMENT1 11
//#define SCE_CAML_COMMENT2 12
//#define SCE_CAML_COMMENT3 13
//#define SCE_HA_DEFAULT 0
//#define SCE_HA_IDENTIFIER 1
//#define SCE_HA_KEYWORD 2
//#define SCE_HA_NUMBER 3
//#define SCE_HA_STRING 4
//#define SCE_HA_CHARACTER 5
//#define SCE_HA_CLASS 6
//#define SCE_HA_MODULE 7
//#define SCE_HA_CAPITAL 8
//#define SCE_HA_DATA 9
//#define SCE_HA_IMPORT 10
//#define SCE_HA_OPERATOR 11
//#define SCE_HA_INSTANCE 12
//#define SCE_HA_COMMENTLINE 13
//#define SCE_HA_COMMENTBLOCK 14
//#define SCE_HA_COMMENTBLOCK2 15
//#define SCE_HA_COMMENTBLOCK3 16
//#define SCE_T3_DEFAULT 0
//#define SCE_T3_PREPROCESSOR 1
//#define SCE_T3_BLOCK_COMMENT 2
//#define SCE_T3_LINE_COMMENT 3
//#define SCE_T3_OPERATOR 4
//#define SCE_T3_KEYWORD 5
//#define SCE_T3_NUMBER 6
//#define SCE_T3_BRACKET 7
//#define SCE_T3_HTML_TAG 8
//#define SCE_T3_HTML_STRING 9
//#define SCE_T3_S_STRING 10
//#define SCE_T3_S_LIB_DIRECTIVE 11
//#define SCE_T3_S_MSG_PARAM 12
//#define SCE_T3_S_H_DEFAULT 13
//#define SCE_T3_D_STRING 14
//#define SCE_T3_D_LIB_DIRECTIVE 15
//#define SCE_T3_D_MSG_PARAM 16
//#define SCE_T3_D_H_DEFAULT 17
//#define SCE_T3_X_DEFAULT 18
//#define SCE_T3_X_PREPROCESSOR 19
//#define SCE_T3_X_BLOCK_COMMENT 20
//#define SCE_T3_X_LINE_COMMENT 21
//#define SCE_T3_X_S_STRING 22
//#define SCE_T3_X_S_LIB_DIRECTIVE 23
//#define SCE_T3_X_S_MSG_PARAM 24
//#define SCE_T3_X_S_H_DEFAULT 25
//#define SCE_T3_X_D_STRING 26
//#define SCE_T3_X_D_LIB_DIRECTIVE 27
//#define SCE_T3_X_D_MSG_PARAM 28
//#define SCE_T3_X_D_H_DEFAULT 29
//#define SCE_T3_USER1 30
//#define SCE_T3_USER2 31
//#define SCE_REBOL_DEFAULT 0
//#define SCE_REBOL_COMMENTLINE 1
//#define SCE_REBOL_COMMENTBLOCK 2
//#define SCE_REBOL_PREFACE 3
//#define SCE_REBOL_OPERATOR 4
//#define SCE_REBOL_CHARACTER 5
//#define SCE_REBOL_QUOTEDSTRING 6
//#define SCE_REBOL_BRACEDSTRING 7
//#define SCE_REBOL_NUMBER 8
//#define SCE_REBOL_PAIR 9
//#define SCE_REBOL_TUPLE 10
//#define SCE_REBOL_BINARY 11
//#define SCE_REBOL_MONEY 12
//#define SCE_REBOL_ISSUE 13
//#define SCE_REBOL_TAG 14
//#define SCE_REBOL_FILE 15
//#define SCE_REBOL_EMAIL 16
//#define SCE_REBOL_URL 17
//#define SCE_REBOL_DATE 18
//#define SCE_REBOL_TIME 19
//#define SCE_REBOL_IDENTIFIER 20
//#define SCE_REBOL_WORD 21
//#define SCE_REBOL_WORD2 22
//#define SCE_REBOL_WORD3 23
//#define SCE_REBOL_WORD4 24
//#define SCE_REBOL_WORD5 25
//#define SCE_REBOL_WORD6 26
//#define SCE_REBOL_WORD7 27
//#define SCE_REBOL_WORD8 28
Constant Long SCE_SQL_DEFAULT = 0
Constant Long SCE_SQL_COMMENT = 1
Constant Long SCE_SQL_COMMENTLINE = 2
Constant Long SCE_SQL_COMMENTDOC = 3
Constant Long SCE_SQL_NUMBER = 4
Constant Long SCE_SQL_WORD = 5
Constant Long SCE_SQL_STRING = 6
Constant Long SCE_SQL_CHARACTER = 7
//#define SCE_SQL_SQLPLUS 8
//#define SCE_SQL_SQLPLUS_PROMPT 9
//#define SCE_SQL_OPERATOR 10
//#define SCE_SQL_IDENTIFIER 11
//#define SCE_SQL_SQLPLUS_COMMENT 13
Constant Long SCE_SQL_COMMENTLINEDOC = 15
//#define SCE_SQL_WORD2 16
//#define SCE_SQL_COMMENTDOCKEYWORD 17
//#define SCE_SQL_COMMENTDOCKEYWORDERROR 18
Constant Long SCE_SQL_USER1 = 19
//#define SCE_SQL_USER2 20
//#define SCE_SQL_USER3 21
//#define SCE_SQL_USER4 22
//#define SCE_ST_DEFAULT 0
//#define SCE_ST_STRING 1
//#define SCE_ST_NUMBER 2
//#define SCE_ST_COMMENT 3
//#define SCE_ST_SYMBOL 4
//#define SCE_ST_BINARY 5
//#define SCE_ST_BOOL 6
//#define SCE_ST_SELF 7
//#define SCE_ST_SUPER 8
//#define SCE_ST_NIL 9
//#define SCE_ST_GLOBAL 10
//#define SCE_ST_RETURN 11
//#define SCE_ST_SPECIAL 12
//#define SCE_ST_KWSEND 13
//#define SCE_ST_ASSIGN 14
//#define SCE_ST_CHARACTER 15
//#define SCE_ST_SPEC_SEL 16
//#define SCE_FS_DEFAULT 0
//#define SCE_FS_COMMENT 1
//#define SCE_FS_COMMENTLINE 2
//#define SCE_FS_COMMENTDOC 3
//#define SCE_FS_COMMENTLINEDOC 4
//#define SCE_FS_COMMENTDOCKEYWORD 5
//#define SCE_FS_COMMENTDOCKEYWORDERROR 6
//#define SCE_FS_KEYWORD 7
//#define SCE_FS_KEYWORD2 8
//#define SCE_FS_KEYWORD3 9
//#define SCE_FS_KEYWORD4 10
//#define SCE_FS_NUMBER 11
//#define SCE_FS_STRING 12
//#define SCE_FS_PREPROCESSOR 13
//#define SCE_FS_OPERATOR 14
//#define SCE_FS_IDENTIFIER 15
//#define SCE_FS_DATE 16
//#define SCE_FS_STRINGEOL 17
//#define SCE_FS_CONSTANT 18
//#define SCE_FS_ASM 19
//#define SCE_FS_LABEL 20
//#define SCE_FS_ERROR 21
//#define SCE_FS_HEXNUMBER 22
//#define SCE_FS_BINNUMBER 23
//#define SCE_CSOUND_DEFAULT 0
//#define SCE_CSOUND_COMMENT 1
//#define SCE_CSOUND_NUMBER 2
//#define SCE_CSOUND_OPERATOR 3
//#define SCE_CSOUND_INSTR 4
//#define SCE_CSOUND_IDENTIFIER 5
//#define SCE_CSOUND_OPCODE 6
//#define SCE_CSOUND_HEADERSTMT 7
//#define SCE_CSOUND_USERKEYWORD 8
//#define SCE_CSOUND_COMMENTBLOCK 9
//#define SCE_CSOUND_PARAM 10
//#define SCE_CSOUND_ARATE_VAR 11
//#define SCE_CSOUND_KRATE_VAR 12
//#define SCE_CSOUND_IRATE_VAR 13
//#define SCE_CSOUND_GLOBAL_VAR 14
//#define SCE_CSOUND_STRINGEOL 15
//#define SCLEX_ASP 29
//#define SCLEX_PHP 30

Long il_SCI
Long il_col = 0
Long il_line = 0
end variables

forward prototypes
public function integer of_resize (long al_width, long al_height)
public function integer of_setcolorcomments (long al_color)
public function integer of_setcolorkeywords (long al_color)
public function integer of_setcolorstring (long al_color)
public function integer of_setcolorcharacter (long al_color)
public function integer of_linenumbers (boolean ab_show)
public function integer of_setfont (string as_font)
public function integer of_setlanguage (string as_language)
public function integer of_settext (string as_text)
public function integer of_setcolorselected (long al_color)
public function string of_gettext ()
public function integer of_setkeywords (string as_keywords)
public function string of_getkeywords (string as_language)
public function integer of_setfontsize (long ai_size)
public function string of_getselectedtext ()
public function integer of_undo ()
public function integer of_copy ()
public function integer of_cut ()
public function integer of_paste ()
public function integer of_print ()
public function integer of_setfocus ()
public function boolean of_ismodified ()
public function integer of_setnotmodified ()
public function integer of_setcolormargin (long al_color)
public function integer of_selectall ()
public function integer of_setparent (long al_parent)
public function integer of_replaceselectedtext (string as_text)
public function integer of_gotoline (long al_line)
public function long of_getcurrentcolumn ()
public function long of_getcurrentline ()
public function integer of_popupenabled (boolean ab_enabled)
public function integer of_setuser1 (string as_keywords)
public function integer of_setcoloruser1 (long al_color)
public function integer of_setcolorkeywordback (long al_color)
public function integer of_setcolorcommentback (long al_color)
public function integer of_setcolorstringback (long al_color)
public function integer of_setcolorcharacterback (long al_color)
public function integer of_setcolordefault (long al_color)
public function integer of_setcolordefaultback (long al_color)
public function integer of_setcolornumberback (long al_color)
public function integer of_setcolornumber (long al_color)
public function integer of_setfontbold (integer ai_bold)
public function integer of_setfontunderline (integer ai_underline)
public function integer of_setfontitalic (integer ai_italic)
public function integer of_inserttext (string as_text)
public subroutine of_format ()
public function string of_replace (string as_source, string as_old, string as_new)
public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function string of_convertkeyword (string as_word)
end prototypes

event resize;r_1.Resize(newwidth, newheight)
of_Resize(newwidth, newheight)
end event

public function integer of_resize (long al_width, long al_height);SetWindowPos(il_SCI, 0, 2, 2, al_width / 15 - 12, al_height / 15 - 30, 0)
THIS.Width = al_width
THIS.Height = al_height

SetWindowPos(il_SCI, 0, 2, 2, UnitsToPixels(al_width, XUnitsToPixels! ) - 3,&
                              UnitsToPixels(al_height, YUnitsToPixels!) - 4, 0)
THIS.Resize(al_width, al_height)

RETURN 1
end function

public function integer of_setcolorcomments (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_COMMENT,al_color)
SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_COMMENTLINE,al_color)
SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_COMMENTDOC,al_color)
//SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_COMMENTLINEDOC,al_color)

RETURN 1
end function

public function integer of_setcolorkeywords (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_WORD,al_color)

RETURN 1
end function

public function integer of_setcolorstring (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_STRING,al_color)

RETURN 1
end function

public function integer of_setcolorcharacter (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_CHARACTER,al_color)

RETURN 1
end function

public function integer of_linenumbers (boolean ab_show);IF ab_show THEN
	SendMessage(il_SCI, SCI_SETMARGINWIDTHN, 0, 45)
ELSE
	SendMessage(il_SCI, SCI_SETMARGINWIDTHN, 0, 0)
END IF

RETURN 1
end function

public function integer of_setfont (string as_font);SendMessageString(il_SCI, SCI_STYLESETFONT, STYLE_DEFAULT,as_font)

RETURN 1
end function

public function integer of_setlanguage (string as_language);//SendMessage(il_SCI, SCI_SETLEXER, 0, SCLEX_SQL)

SendMessageString(il_SCI, SCI_SETLEXERLANGUAGE,0, as_language)


RETURN 1
end function

public function integer of_settext (string as_text);SendMessageString(il_SCI, SCI_SETTEXT, Len(as_text), as_text)

of_SetNotModified()

RETURN 1
end function

public function integer of_setcolorselected (long al_color);SendMessage(il_SCI, SCI_SETSELBACK, 1, al_color)

RETURN 1
end function

public function string of_gettext ();String ls_text
Long ll_length

ll_length = SendMessage(il_SCI, SCI_GETTEXTLENGTH, 0, 0)

ll_length = ll_length + 1

ls_text = Space(ll_length)
SendMessageString(il_SCI, SCI_GETTEXT, ll_length, ls_text)

RETURN ls_text

end function

public function integer of_setkeywords (string as_keywords);
SendMessageString(il_SCI, SCI_SETKEYWORDS,0,as_keywords)

RETURN 1
end function

public function string of_getkeywords (string as_language);String ls_keywords

CHOOSE CASE Lower(as_language)
	CASE 'sql'
		ls_keywords = "add all alter and any as asc avg begin " + &
		              "between binary break by call cascade cast " + &
						  "char char_convert character check checkpoint " + &
						  "close comment commit connect constraint continue " + &
						  "convert count create cross current cursor date " + &
						  "dateadd datediff datename datepart datetime day " + &
						  "dba dbspace dbo deallocate dec decimal declare default " + &
						  "delete desc distinct do double drop else elseif " + &
						  "encrypted end endif escape exception exec execute exists " + &
						  "fetch first float for foreign from full getdate getutcdate " + &
						  "goto grant group having holdlock identified if in index " + &
						  "initial inner inout insert instead int integer into is isolation " + &
						  "join key left len like lock long match max min membership " + &
						  "message mode modify month named natural next noholdlock not " + &
						  "null number numeric object_id of off on open option options or order " + &
						  "others out outer passthrough pctincrease precision prepare " + &
						  "primary print privileges proc procedure raiserror readtext " + &
						  "real reference references release remote rename replace " + &
						  "resource restrict return revoke right rollback save savepoint " + &
						  "schedule select set share smallint some sqlcode sqlstate " + &
						  "start stop storage subtrans subtransaction sum suser_name synchronize " + &
						  "syntax_error sys table tablespace temporary then time tinyint " + &
						  "to tran trigger truncate tsequal union unique unknown update " + &
						  "user using validate values varbinary varchar varchar2 variable " + &
						  "varying view when where while with work writetext year rowcount error "
END CHOOSE

RETURN ls_keywords
end function

public function integer of_setfontsize (long ai_size);SendMessage(il_SCI, SCI_STYLESETSIZE, STYLE_DEFAULT, ai_size)

RETURN 1
end function

public function string of_getselectedtext ();String ls_text
Long ll_start, ll_end, ll_length

ll_start = SendMessage(il_SCI, SCI_GETSELECTIONSTART, 0, 0)
ll_end   = SendMessage(il_SCI, SCI_GETSELECTIONEND, 0, 0)

ll_length = ll_end - ll_start
ls_text = Space(ll_length)

SendMessageString(il_SCI, SCI_GETSELTEXT, ll_length, ls_text)

RETURN ls_text
end function

public function integer of_undo ();SendMessage(il_SCI, SCI_UNDO, 0, 0)

RETURN 1
end function

public function integer of_copy ();SendMessage(il_SCI, SCI_COPY, 0, 0)

RETURN 1
end function

public function integer of_cut ();SendMessage(il_SCI, SCI_CUT, 0, 0)
Send(Handle(PARENT), 1024, 0, 0)
RETURN 1
end function

public function integer of_paste ();SendMessage(il_SCI, SCI_PASTE, 0, 0)
Send(Handle(PARENT), 1024, 0, 0)
RETURN 1
end function

public function integer of_print ();Long ll_print

ll_print = PrintOpen()
Print(ll_print, of_GetText())
PrintClose(ll_print)

RETURN 1
end function

public function integer of_setfocus ();
SendMessage(il_SCI, SCI_SETFOCUS, 1, 1)
SetFocus(THIS)

//Windows Message - lbuttondown
SendMessage(il_SCI, 513, 1000, 1000)
//Windows Message - lbuttonup
SendMessage(il_SCI, 514, 1000, 1000)

RETURN 1
end function

public function boolean of_ismodified ();Long ll_return

ll_return = SendMessage(il_SCI, SCI_GETMODIFY, 0, 0)

IF ll_return <= 0 THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF

end function

public function integer of_setnotmodified ();
SendMessage(il_SCI, SCI_SETSAVEPOINT, 0, 0)

RETURN 1
end function

public function integer of_setcolormargin (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK, STYLE_LINENUMBER, al_color)

RETURN 1
end function

public function integer of_selectall ();SendMessage(il_SCI, SCI_SELECTALL, 0, 0)

RETURN 1
end function

public function integer of_setparent (long al_parent);
RETURN SetParent(il_SCI, al_parent)
end function

public function integer of_replaceselectedtext (string as_text);
SendMessageString(il_SCI, SCI_REPLACESEL, 0, as_text)

RETURN 1
end function

public function integer of_gotoline (long al_line);SendMessage(il_SCI, SCI_GOTOLINE, al_line, 0)
Send(Handle(PARENT), 1024, 0, 0)
RETURN 1
end function

public function long of_getcurrentcolumn ();Long caretPos

caretPos = SendMessage(il_SCI, SCI_GETCURRENTPOS, 0, 0)

RETURN SendMessage(il_SCI, SCI_GETCOLUMN, caretPos, 0) + 1

end function

public function long of_getcurrentline ();Long caretPos

caretPos = SendMessage(il_SCI, SCI_GETCURRENTPOS, 0, 0)

RETURN SendMessage(il_SCI, SCI_LINEFROMPOSITION, caretPos, 0) + 1

end function

public function integer of_popupenabled (boolean ab_enabled);ib_enablepopup = ab_enabled

RETURN 1
end function

public function integer of_setuser1 (string as_keywords);
SendMessageString(il_SCI, SCI_SETKEYWORDS,4,as_keywords)

RETURN 1
end function

public function integer of_setcoloruser1 (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_user1,RGB(255,255,255))
SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_user1,al_color)

RETURN 1
end function

public function integer of_setcolorkeywordback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_WORD,al_color)

RETURN 1
end function

public function integer of_setcolorcommentback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_COMMENT,al_color)
SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_COMMENTLINE,al_color)
SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_COMMENTDOC,al_color)

RETURN 1
end function

public function integer of_setcolorstringback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_STRING,al_color)

RETURN 1
end function

public function integer of_setcolorcharacterback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_CHARACTER,al_color)

RETURN 1
end function

public function integer of_setcolordefault (long al_color);//SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_DEFAULT,al_color)
SendMessage(il_SCI, SCI_SETWHITESPACEFORE,al_color,al_color)

RETURN 1
end function

public function integer of_setcolordefaultback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_DEFAULT,al_color)

RETURN 1
end function

public function integer of_setcolornumberback (long al_color);SendMessage(il_SCI, SCI_STYLESETBACK,SCE_SQL_NUMBER,al_color)

RETURN 1
end function

public function integer of_setcolornumber (long al_color);SendMessage(il_SCI, SCI_STYLESETFORE,SCE_SQL_NUMBER,al_color)

RETURN 1
end function

public function integer of_setfontbold (integer ai_bold);SendMessage(il_SCI, SCI_STYLESETBOLD, STYLE_DEFAULT, ai_bold)

RETURN 1
end function

public function integer of_setfontunderline (integer ai_underline);SendMessage(il_SCI, SCI_STYLESETUNDERLINE, STYLE_DEFAULT, ai_underline)

RETURN 1
end function

public function integer of_setfontitalic (integer ai_italic);SendMessage(il_SCI, SCI_STYLESETITALIC, STYLE_DEFAULT, ai_italic)

RETURN 1
end function

public function integer of_inserttext (string as_text);SendMessageString(il_SCI, SCI_INSERTTEXT, -1, as_text)

RETURN 1
end function

public subroutine of_format ();String ls_text, ls_newtext, ls_word
String ls_array[], ls_space, ls_space2, ls_return
Long ll_space = 1
Long ll_count, ll_index, ll_lastreturnpos, ll_lastselectspace
Long ll_pos = 0, ll_selectspace = 6
Boolean lb_bracketopen = FALSE
Boolean lb_insertstarted = FALSE

ls_text = of_GetText()

ls_text = of_Replace(ls_text, '~t', ' ')
ls_text = of_Replace(ls_text, '~r', ' ')
ls_text = of_Replace(ls_text, '~n', ' ')
ls_text = of_Replace(ls_text, '(', ' ( ')
ls_text = of_Replace(ls_text, ')', ' ) ')

of_ParseToArray(ls_text, ' ', ls_array)

ll_count = UpperBound(ls_array)

FOR ll_index = 1 TO ll_count
	
	ls_word = Trim(ls_array[ll_index])
	
	IF Len(ls_word) = 0 THEN CONTINUE
	
	IF ls_word = '(' THEN 
		lb_bracketopen = TRUE
		ll_lastselectspace = Len(ls_newtext) - ll_lastreturnpos
		ll_selectspace = ll_selectspace + ll_lastselectspace + 9
	END IF
	
	IF ls_word = ')' THEN 
		lb_bracketopen = FALSE
		ll_selectspace = ll_selectspace - ll_lastselectspace - 9
		IF ll_selectspace <= 0 THEN ll_selectspace = 6
	END IF


	IF (Lower(ls_word) = 'group' OR &
		Lower(ls_word) = 'and' OR &
		Lower(ls_word) = 'or' OR &
		Lower(ls_word) = 'having' OR &
		Lower(ls_word) = 'from' OR &
		Lower(ls_word) = 'order' OR &
		Lower(ls_word) = 'values' OR &
		Lower(ls_word) = 'set' OR &
		Lower(ls_word) = 'where') AND NOT &
		(Lower(ls_word) = 'or' AND lb_bracketopen) THEN
		
		IF Lower(ls_word) = 'values' THEN
			lb_insertstarted = FALSE
	   END IF
		
			ll_pos = 0
			ls_return = '~r~n'
			ll_space = ll_selectspace - Len(ls_word)

	ELSE
		IF Right(ls_word, 1) = ',' THEN
			ll_pos = 1
			ls_return = '~r~n'
			ll_space = ll_selectspace
			ls_space2 = ' '
		ELSE
			
			IF (Lower(ls_word) = 'select' OR &
				 Lower(ls_word) = 'insert' OR &
				 Lower(ls_word) = 'delete' OR &
				 Lower(ls_word) = 'update') AND &
				 NOT lb_bracketopen THEN
					
					
				IF Lower(ls_word) = 'insert' THEN
					lb_insertstarted = TRUE
				END IF
				
				IF lb_insertstarted AND Lower(ls_word) = 'select' THEN
					lb_insertstarted = FALSE
					ls_return = '~r~n'
				ELSE
 				ls_return = '~r~n~r~n'
				END IF
				
				ll_space = 0
				ls_space2 = ''
				ll_pos = 0
			
			ELSE
					ls_return = ''
					ll_space = 0	
					ls_space2 = ' '
					ll_pos = 1
			END IF
		END IF
	END IF
	
	ls_space = Space(ll_space)
	
//	ls_word = of_ConvertKeyword(ls_word)
	
	IF ll_pos = 0 THEN
		IF ll_index = 1 THEN ls_return = ''

		ls_newtext = ls_newtext + ls_return + ls_space + ls_word
	ELSE
		ls_newtext = ls_newtext + ls_space2 + ls_word + ls_return + ls_space 
	END IF
	
	IF ls_return = '~r~n' THEN ll_lastreturnpos = Len(ls_newtext)
	
NEXT

of_SetText(ls_newtext + '~r~n')
end subroutine

public function string of_replace (string as_source, string as_old, string as_new);Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
IF IsNull(as_source) OR IsNull(as_old) OR IsNull(as_new) THEN
	string ls_null
	SetNull(ls_null)
	RETURN ls_null
	
END IF

//Get the string lenghts
ll_OldLen = Len(as_Old)
ll_NewLen = Len(as_New)

as_old = Lower(as_old)
ls_source = Lower(as_source)

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_Old)

DO WHILE ll_Start > 0
	// replace as_Old with as_New
	as_Source = Replace(as_Source, ll_Start, ll_OldLen, as_New)

	ls_source = Lower(as_source)

	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_Old, (ll_Start + ll_NewLen))
	
LOOP

RETURN as_Source
end function

public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0  then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

//Return the number of entries found
Return ll_Count
end function

public function string of_convertkeyword (string as_word);//String ls_word
//Long ll_count, ll_index
//
//ll_count = UpperBound(is_keywords)
//
//ls_word = as_word
//
//FOR ll_index = 1 TO ll_count
//	
//	IF Lower(as_word) = Lower(is_keywords[ll_index]) THEN
//		ls_word = Upper(as_word)
//		EXIT
//	END IF
//	
//NEXT

RETURN ''//ls_word
end function

on u_scintilla.create
this.r_1=create r_1
this.Control[]={this.r_1}
end on

on u_scintilla.destroy
destroy(this.r_1)
end on

event constructor;String ls_windowname, ls_system32
Long ll_handle
Long ll_null

SetNull(ll_null)

//Get System32 Folder
ls_system32 = Space(255)
GetSystemDirectory(ls_system32, Len(ls_system32))

//Check to see if dll exists
IF NOT FileExists(ls_system32 + "\SciLexer.DLL") THEN
	MessageBox('Query Builder','You are missing the following dll: ' + ls_system32 + "\SciLexer.DLL~r~n~r~n" + &
	                           'View the readme file for download instructions.~r~n' + &
										'This message box is in the constructor event of u_scintilla.')
	RETURN
END IF

LoadLibrary (ls_system32 + "\SciLexer.DLL")

//1342177280
//WS_EX_CLIENTEDGE
il_SCI = CreateWindowEx(0, "Scintilla", &
        "editor", 1409286144, 0, 0, 200, 200, &
        Handle(THIS), 0, Handle(GetApplication()), 0)

SendMessage(il_SCI, SCI_STYLESETCHARACTERSET, SCE_SQL_STRING, SC_CHARSET_ANSI)
//SendMessage(il_SCI, SCI_USEPOPUP, 0, 0)

SendMessage(il_SCI, SCI_SETHSCROLLBAR, 0, 0)

of_LineNumbers(TRUE)

of_SetFont("Courier New")
of_SetFontSize(9)

of_SetLanguage("sql")
of_SetKeyWords(of_GetKeywords('sql'))

of_SetColorKeywords(RGB(0,0,255))
of_SetColorString(RGB(255,0,0))
of_SetColorCharacter(RGB(255,0,0))
of_SetColorComments(RGB(0,128,0))
of_SetColorMargin(RGB(255,255,255))//RGB(185,210,248))
of_SetColorSelected(RGB(216,228,248))

//of_SetParent(Handle(THIS))

of_SetFocus()

r_1.Resize(Width, Height)
of_Resize(Width, Height)
end event

event destructor;DestroyWindow(il_SCI)
end event

event other;
//CHOOSE CASE Message.Number
//	CASE 123
//		IF ib_enablepopup THEN
//			m_frame.m_edit.PopMenu ( w_frame.PointerX(), w_frame.PointerY())
//		END IF
//		
//	CASE 514, 256, 258
//		Send(Handle(PARENT), 1024, 0, 0)
//		
//END CHOOSE
//
end event

type r_1 from rectangle within u_scintilla
integer linethickness = 4
long fillcolor = 67108864
integer width = 2062
integer height = 1140
end type

event constructor;THIS.LineColor = RGB(127,157,185)
end event

