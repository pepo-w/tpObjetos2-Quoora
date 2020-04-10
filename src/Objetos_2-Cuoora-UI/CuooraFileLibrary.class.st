"
""ejecutando esto se agrega el file a la libreria de Cuoora""
""CuooraFileLibrary addFileAt: 'C:\pharo\plusIcon.png'.""


"
Class {
	#name : #CuooraFileLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #uploaded }
CuooraFileLibrary >> mainCss [
	^ '.right {
  float: right;
}
a {
  text-decoration: none;
  color: rgb(0,15,70);
}
body {
  font-family: Lucida Sans Unicode, Lucida Grande, sans-serif;
}'
]

{ #category : #uploaded }
CuooraFileLibrary >> plusIconpngPng [
	^ #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 40 0 0 0 40 8 6 0 0 0 140 254 184 109 0 0 0 6 98 75 71 68 0 255 0 255 0 255 160 189 167 147 0 0 3 255 73 68 65 84 88 133 237 151 221 79 219 86 24 135 223 227 56 254 136 73 154 164 217 74 8 209 160 82 164 164 55 101 52 155 0 141 141 74 19 173 24 69 147 218 253 13 93 55 77 83 181 141 172 210 46 114 193 85 163 81 105 55 236 127 104 39 141 81 138 246 33 81 173 19 168 21 43 112 149 172 72 75 39 104 66 7 36 44 137 125 108 199 241 217 197 62 152 154 216 113 72 152 84 41 207 85 228 243 59 199 79 206 235 115 124 12 208 166 77 155 231 27 212 138 65 70 226 139 29 12 195 118 219 104 56 1 0 80 209 224 169 170 42 91 119 227 103 75 205 142 125 104 193 209 169 7 65 206 73 95 177 35 52 193 179 172 91 112 48 180 131 99 120 0 0 17 171 88 194 170 134 21 121 95 211 200 172 90 46 207 44 196 6 182 254 23 193 115 211 75 94 135 141 77 240 28 119 62 114 178 203 239 115 59 17 66 181 135 209 9 129 189 124 145 36 211 153 44 150 148 59 170 44 78 206 95 27 206 31 153 224 216 244 253 40 79 51 55 251 35 61 193 227 30 151 173 145 190 59 185 98 101 45 149 222 148 85 229 210 252 199 3 63 183 92 112 226 243 149 119 4 7 247 197 80 95 168 211 110 167 27 113 251 23 85 211 96 121 117 99 91 146 241 7 179 87 95 185 213 50 193 177 233 251 209 99 188 48 55 28 13 119 82 6 229 180 138 78 8 220 91 73 109 23 196 210 184 149 153 164 234 5 206 77 47 121 121 154 185 57 212 23 106 90 14 0 128 66 8 6 95 14 117 114 118 246 214 200 141 69 119 211 130 60 98 19 125 225 222 96 189 178 70 124 8 46 159 161 224 242 25 10 34 62 243 63 194 208 52 244 159 234 9 122 168 99 137 166 4 71 167 30 4 5 7 123 254 5 175 179 161 5 97 133 227 30 151 141 231 152 177 241 169 165 128 89 206 84 144 115 210 87 194 39 3 254 214 170 29 16 238 13 248 237 29 236 123 102 25 83 65 59 66 19 62 183 179 37 111 155 90 248 60 78 68 81 232 130 89 198 80 112 36 190 216 193 179 140 219 104 19 110 5 20 66 192 51 118 239 104 98 93 48 202 24 62 249 12 195 118 11 2 91 179 189 214 34 240 59 159 253 93 157 73 238 146 170 107 14 7 79 211 185 189 0 0 60 106 72 16 217 40 191 192 177 124 173 182 215 95 50 159 213 144 23 65 200 91 125 189 150 160 192 177 188 142 244 46 35 65 195 18 35 157 16 162 155 122 180 6 4 4 217 72 181 249 223 24 111 110 84 37 43 41 10 6 0 215 179 77 63 254 86 61 158 223 249 215 204 1 0 108 228 8 100 139 214 252 36 172 96 13 168 76 195 130 50 46 63 17 37 85 171 213 86 171 84 0 7 101 205 22 141 50 213 136 18 174 32 196 27 10 26 150 248 110 252 108 9 43 202 190 174 91 187 209 97 208 9 1 172 104 123 223 125 114 90 52 202 152 238 131 154 166 207 238 237 23 143 204 112 55 87 32 149 74 229 27 179 140 169 160 90 46 207 36 211 153 108 107 181 14 248 37 157 205 104 146 250 165 89 198 84 112 33 54 176 133 37 229 206 78 174 80 243 89 108 134 157 124 81 43 97 229 246 237 207 134 158 152 229 234 158 60 85 89 156 92 75 61 126 243 141 87 79 245 48 180 113 60 185 75 44 47 12 181 172 193 90 50 189 41 42 122 172 94 182 238 113 107 254 218 112 94 149 229 139 203 171 27 25 221 120 187 178 140 78 8 44 175 110 108 151 42 242 165 31 62 141 254 209 180 32 0 192 220 228 224 67 73 198 31 222 91 73 110 171 218 225 171 173 150 53 248 105 37 149 21 21 229 253 111 175 14 62 180 210 167 161 147 192 133 235 203 253 12 203 125 117 58 210 219 253 162 215 217 208 135 201 239 185 130 182 158 122 188 41 149 241 197 133 143 134 86 173 246 107 248 168 50 114 99 209 237 65 174 235 60 207 190 21 238 233 242 251 188 46 100 244 41 160 235 4 118 243 5 146 250 53 147 197 138 50 87 148 73 204 74 89 155 18 252 135 241 169 165 0 221 193 188 75 81 182 183 29 12 237 113 8 60 45 112 12 15 128 64 148 21 44 137 88 147 84 53 175 107 228 107 177 44 207 124 31 123 205 240 109 113 36 130 255 101 52 177 46 80 122 177 91 39 232 4 0 0 133 200 83 59 230 54 231 226 81 169 21 227 183 105 211 230 121 230 79 223 56 141 245 107 209 129 164 0 0 0 0 73 69 78 68 174 66 96 130]
]