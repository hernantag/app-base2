# app_base_v0

A new Flutter project.

## Getting Started

El proyecto base se divide en app y repository. App contiene manejadores de estado (bloc), screens, models, etc. Repository se utiliza para manejar los datos producidos por fuentes externas (api-macamedia,firebase,etc).

La arquitectura del proyecto sigue el patron BloC ( https://bloclibrary.dev/#/ ) con el cual podemos manejar el estado de forma eficiente y ordenada.

La convenciones para utilzar bloc en un elemento de una aplicacion son:

--\* Crear un archivo state, un archivo event y un archivo bloc. El archivo state es el que va a contener la informacion del estado de nuestro elemento. El archivo event contiene los eventos que van a producir cambios en el state. Por ultimo, el archivo bloc es el que se va a encargar de vincular el state con los events.

Para ejemplificar: teniendo en cuenta el directorio lib\app\authentication\bloc

--\* authentication es el encargado de manejar el estado de autenticacion de la aplicacion. Los posibles estados de authenticacion son Authenticated, Unauthenticated y Unknown , como se puede ver en el archivo state. Los eventos que van a producir cambios en el estado son StatusChanged (podria desdoblarse en varios eventos separados pero de esta manera se evita escribir mas codigo) y LogoutRequest. Y por ultimo, tenemos el archivo Bloc, encargado de vincular los eventos ( luego de inicializar el estado, se declaran los eventos con un "on" y la clase del evento que se va a disparar ) y efectuar acciones para cambiar el estado.

--\* Desde dentro de la aplicacion, para efecutar cambios hay que llamar a estos eventos declarados en el bloc haciendo un Read del context. Para esto hay que proveer el bloc utilizando BlocProvider, BlocBuilder, Bloc Consumer o BlocListener. El mas simple es BlocProvider. https://bloclibrary.dev/#/flutterbloccoreconcepts . Hay que asegurarse de que el provider este disponible en el widget para hacer un context.read<"AQUI-VA-EL-BLOC">().add("AQUI-VA-EL-EVENTO");

--\* read se utiliza para leer una sola vez un dato dentro del bloc, watch para leer constantemente (funciona como un listener).

AL FINAL DEL DIA TODAS SON CONVENCIONES ASI QUE PUEDES HACER LO Q QUIERAS - pero esta es la forma recomendada

HernanTag????????????????
#   a p p - b a s e 2  
 