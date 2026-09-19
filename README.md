[![GitHub stars](https://img.shields.io/github/stars/kontroldev/Proyecto_1_Pomodoro?style=social)](https://github.com/kontroldev/Proyecto_1_Pomodoro/stargazers)

# PomodoroApp

Proyecto colaborativo para desarrollar una aplicación de Pomodoro con métricas y estadísticas. Este proyecto es parte de la iniciativa de [MoureDev](https://github.com/mouredev) para practicar y mejorar nuestras habilidades en Swift y trabajo colaborativo.

## 🔄 Evolución del proyecto

La fase de colaboración de la comunidad para este proyecto ya ha finalizado. A partir de este punto, el proyecto entra en una nueva etapa centrada en su **refactorización y evolución**.

El objetivo de esta nueva fase es revisar y mejorar progresivamente la arquitectura, la organización del código y la implementación de las diferentes funcionalidades, aplicando los conocimientos y criterios de programación en **Swift y SwiftUI** que voy adquiriendo durante mi formación como desarrollador iOS.

Esta evolución también busca transformar el proyecto original en un proyecto más personal y representativo de mi forma de trabajar, manteniendo como base todo lo aprendido durante la etapa colaborativa.

El resultado final formará parte de mi **portfolio como desarrollador iOS**, mostrando no solo una aplicación funcional, sino también la evolución del código, las decisiones técnicas tomadas y mi progreso como desarrollador.

## 🚀 Objetivo
Crear una aplicación funcional que permita a los usuarios:
- Gestionar su tiempo con la técnica Pomodoro.
- Visualizar métricas y estadísticas de su progreso.
- En futuras iteraciones, gestionar tareas y hábitos.

## 🛠️ Tecnologías
- **Swift 6**: Lenguaje principal para la implementación de la app.
- **SwiftUI**: Para construir la interfaz de usuario.
- **GitHub**: Plataforma para la colaboración y gestión del repositorio.
- **iOS 18.2**: Versión mínima requerida del sistema operativo.

## 📜 Licencia
Este proyecto está licenciado bajo la [MIT License](LICENSE).

## 👥 Equipo
- **Gestor de Swift**: [kontroldev](https://github.com/kontroldev)    
- **Colaboradores**:  
  - [Lordzzz](https://github.com/lordzzz777)  
  - [Yeikobu](https://github.com/yeikobu)  
  - [Alejosor](https://github.com/Alejosor)  
  - [Larafuzas](https://github.com/JuitoMG)  
  - [ManuelCBR](https://github.com/ManuelCBR)  
  - [Matías Álvarez](https://github.com/MGAlvarez1989)

## 🎨 Diseño del Proyecto
- **Diseñadores**:
  - [Rusalka](https://github.com/rcellas)  
  - [Rick](https://github.com/Rickmij)  

Puedes consultar el diseño preliminar del proyecto en Figma:  
[Diseño en Figma](https://www.figma.com/design/GdZmsgDPXeJGc9zLgesPaD/App-Habitos?node-id=15-43&p=f&t=Q08Jbj7W5ixDp4Qq-0)

---

## 🌐 Proyectos Paralelos
Este proyecto está acompañado por dos desarrollos paralelos que comparten la misma funcionalidad básica, pero en diferentes plataformas:

- [Proyecto Kotlin](https://github.com/juanppdev/Proyecto_1_Pomodoro)  
- [Proyecto Web](https://github.com/ProyectosWebComunidadMoureDev/PomodoroWeb/tree/main)  

---

## 🖼️ Imágenes del Proyecto

A continuación se muestran algunas capturas del desarrollo de la aplicación:
 
<img width="300"  alt="login" src="https://github.com/user-attachments/assets/1f8339aa-f988-4a5c-ae96-7673245b6cc5" />   
<img width="300"  alt="Pantalla temporizador" src="https://github.com/user-attachments/assets/0726818c-a1a1-41be-a071-87c559c225a5" />

---

## 📝 Registro de cambios

### 2026-09-19
- Diagnosticado el error de compilación `Cannot find 'HomeView' in scope` en `Proyecto_1_PomodoroApp.swift`. La causa era que Xcode tenía abierta la carpeta de archivos suelta en lugar del `Proyecto_1_Pomodoro.xcodeproj`, por lo que generaba un build ad-hoc de un solo archivo que no incluía `HomeView.swift`, `PomodoroSessionModel.swift` ni el resto de fuentes del target. No fue necesario modificar el código: `HomeView` y el resto de tipos ya son miembros del target a través de los grupos sincronizados con el sistema de archivos del proyecto. Solución: abrir el `.xcodeproj` directamente en Xcode.

¡Gracias por contribuir y formar parte de este proyecto! 💪
