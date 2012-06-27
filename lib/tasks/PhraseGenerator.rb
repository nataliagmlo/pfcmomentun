#Generates a random phrase
class PhraseGenerator

	def generate i

		@phrase = ["<xml><user><name>usuario1</name><id>9871</id><audiencia>12</audiencia></user><mensaje>Poesia es la union de dos palabras que uno nunca supuso que pudieran juntarse, y que forman algo asi como un misterio.</mensaje></xml>",
		"<xml><user><name>usuario2</name><id>9872</id><audiencia>22</audiencia></user><mensaje>La poesia huye, a veces, de los libros para anidar extramuros, en la calle, en el silencio, en los suenos, en la piel, en los escombros, incluso en la basura. Donde no suele cobijarse nunca es en el verbo de los subsecretarios, de los comerciantes o de los lechuginos de television.</mensaje></xml>",
		"<xml><user><name>usuario3</name><id>9873</id><audiencia>32</audiencia></user><mensaje>Al contacto del amor todo el mundo se vuelve poeta.</mensaje></xml>",
		"<xml><user><name>usuario4</name><id>9874</id><audiencia>42</audiencia></user><mensaje>La poesia es el sentimiento que le sobra al corazon y te sale por la mano.</mensaje></xml>",
		"<xml><user><name>usuario5</name><id>9875</id><audiencia>52</audiencia></user><mensaje>Los poetas inmaduros imitan; los poetas maduros roban; los malos estropean lo que roban, y los buenos lo convierten en algo mejor.</mensaje></xml>",
		"<xml><user><name>usuario6</name><id>9876</id><audiencia>62</audiencia></user><mensaje>Digamos que existen dos tipos de mentes poeticas: una apta para inventar fabulas y otra dispuesta a creerlas.</mensaje></xml>",
		"<xml><user><name>usuario7</name><id>9877</id><audiencia>72</audiencia></user><mensaje>No digais que, agotado su tesoro, de asuntos falta, enmudecio la lira: podra no haber poetas pero siempre habra poesia.</mensaje></xml>",
		"<xml><user><name>usuario8</name><id>9878</id><audiencia>82</audiencia></user><mensaje>Cada poema es unico. En cada obra late, con mayor o menor grado, toda la poesia. Cada lector busca algo en el poema. Y no es insolito que lo encuentre: Ya lo llevaba dentro.</mensaje></xml>",
		"<xml><user><name>usuario9</name><id>9879</id><audiencia>92</audiencia></user><mensaje>La poesia es el eco de la melodia del universo en el corazon de los humanos.</mensaje></xml>",
		"<xml><user><name>usuario10</name><id>98710</id><audiencia>102</audiencia></user><mensaje>Hacer versos malos depara mas felicidad que leer los versos mas bellos.</mensaje></xml>"]

		return @phrase[i]
	end


end