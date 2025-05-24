# **devGarage 🚗**

Um aplicativo Flutter completo para gerenciamento de carros, desenvolvido com arquitetura limpa e padrão Provider para gerenciamento de estado.

## **📱 Sobre o Projeto**
O **devGarage** é uma aplicação mobile que permite aos usuários gerenciar uma coleção de carros de forma simples e intuitiva. O app oferece funcionalidades completas de CRUD (Create, Read, Update, Delete) para carros, integrando com APIs externas para uma experiência rica e dinâmica.

## ✨ Funcionalidades

- **📋 Listagem de Carros:** Visualize todos os carros cadastrados em uma interface clean
- **➕ Cadastro:** Adicione novos carros com informações detalhadas
- **✏️ Edição:** Modifique as informações dos carros existentes
- **🗑️ Exclusão:** Remova carros da sua coleção
- **👀 Detalhes:** Visualize informações completas de cada carro
- **🌐 Integração com API:** Consome dados de APIs externas
- **💾 Persistência Local:** Armazenamento local para melhor performance

## **🏗️ Arquitetura**

```
O projeto segue uma arquitetura bem estruturada e organizada:
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/
│   └── car_model.dart       # Modelo de dados do carro
├── providers/
│   └── car_provider.dart    # Gerenciamento de estado com Provider
├── screens/
│   ├── add_car_screen.dart  # Tela de cadastro de carros
│   ├── car_detail_screen.dart # Tela de detalhes do carro
│   ├── edit_car_screen.dart # Tela de edição de carros
│   └── home_screen.dart     # Tela principal
├── services/
│   ├── car_api_service.dart # Serviço de integração com API
│   └── car_database.dart    # Serviço de banco de dados local
└── widgets/
└── car_card.dart        # Widget reutilizável para exibir carros
```

## **🛠️ Tecnologias Utilizadas**

- **Flutter:** Framework principal para desenvolvimento mobile
- **Provider:** Gerenciamento de estado reativo
- **HTTP:** Requisições para APIs externas
- **SQLite:** Banco de dados local 

## **🚀 Como Executar**
### **Pré-requisitos**

- Flutter SDK instalado
- Dart SDK
- Android Studio ou VS Code
- Dispositivo/Emulador Android ou iOS

**Instalação**

1. Clone o repositório:
```bash
bashgit clone git@github.com:GuilhermeMooser/FlutterDevGarage.git
cd devgarage
```
2. Instale as dependências:
```bash
bashflutter pub get
```
3. Execute o aplicativo:
```bash
bashflutter run
```

## **📦 Dependências Principais**
```yaml
dependencies:
    flutter:
        sdk: flutter
    provider: ^6.0.0
    http: ^0.13.0
    sqflite: ^2.3.2
    path: ^1.9.0
    google_fonts: ^6.1.0
```

**🎯 Padrões Utilizados**

- **Provider Pattern:** Para gerenciamento de estado global
- **Repository Pattern:** Separação entre dados locais e remotos
- **Widget Composition:** Componentização com widgets reutilizáveis
- **Clean Architecture:** Separação clara de responsabilidades

**📱 Telas do App**

1. **Home Screen:** Lista todos os carros cadastrados
2. **Add Car Screen:** Formulário para cadastrar novos carros
3. **Edit Car Screen:** Formulário para editar carros existentes
4. **Car Detail Screen:** Exibe detalhes completos de um carro específico

**🔧 Estrutura de Dados**

O modelo de carro (car_model.dart) contém as informações essenciais para representar um veículo no sistema, integrando tanto dados locais quanto externos via API.

**👨‍💻 Desenvolvido por**

**devGarage Team** - Guilherme Moser e Ranilson Ribeiro

---

**🚗 Gerencie sua garagem digital com estilo!**