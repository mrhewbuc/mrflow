# MrFlow - Agentic Flows for Salesforce

> 🚀 **Bringing AI-powered automation to Salesforce** - An open-source passion project empowering developers, admninstrators and SMBs with intelligent flow orchestration.

[![Salesforce API](https://img.shields.io/badge/Salesforce%20API-v64.0-blue)](https://developer.salesforce.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Package Version](https://img.shields.io/badge/Package-v0.1.0.2--BETA-orange)](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tJ8000000xA9WIAU)

## 🎯 Vision

MrFlow democratizes AI-powered automation in Salesforce by providing "Agentic" Flow capabilities without requiring expensive licenses. Built as a passion project for the Salesforce community, we're making intelligent automation accessible to developers and small-to-medium businesses who need sophisticated flow orchestration without enterprise costs.

### 🏗️ Architecture Philosophy

**Flow-First, Code-Minimal**: We believe in maximizing declarative development. While some Apex is necessary for advanced functionality, our goal is to empower admins and developers to build AI-powered automation primarily through Flows, keeping the codebase lean and maintainable.

## ✨ Why MrFlow?

- **🆓 Open Source**: Full transparency and community-driven development
- **📦 Easy Installation**: Available as a managed package for quick deployment
- **🤖 AI-Native**: Built-in AI integration for intelligent decision-making
- **⚡ Async by Design**: Non-blocking flow execution prevents governor limits
- **🔧 Developer-Friendly**: Extensible architecture for custom implementations
- **💼 SMB-Focused**: Affordable AI automation for growing businesses

## 🚀 Quick Start

### Install via Package

Install the latest version directly in your Salesforce org:

**Sandbox:**
```
https://test.salesforce.com/packaging/installPackage.apexp?p0=04tJ8000000xAsAIAU
```

## 🎨 Current Features

### ✅ Available Now

#### 🤖 AI Integration Layer
- **OpenAI GPT Integration**: Connect flows to OpenAI models
- **Tool Handling**: Serialize/deserialize AI function calls within flows(template: tool_get_active_asset_list included)
- **External Service Framework**: Robust API integration

#### ⚡ Flow-Based AI Orchestration
- **Dedicated OpenAI Response Endpoint Flow**: Specialized flow (`OpenAI_Async_Call_Response_Endpoint`) exclusively handles OpenAI responses endpoint with built-in error handling and routing
- **Bring Your Own API Key**: With external credentials, you can use your own account
- **Async(Future) Flow Execution**: Run flows in the background without blocking users
- **Minimal Apex Footprint**: Strategic use of Apex only where necessary - most logic lives in Flows
- **Platform Event Architecture**: Decouple flow components for better scalability and handoff capabilities

#### 🎛️ Metadata-Driven Configuration
- **AI Conductor Settings**: Configure AI models and configuration via custom metadata

#### 📧 Intelligent Automation Patterns

### 1️⃣ OpenAI Response Endpoint Flow
A dedicated, optimized flow specifically for OpenAI integration:
- Pre-configured for GPT models using Response Endpoint
- Easy use of the Response ID for memory management

## 🗺️ Roadmap

### 🔄 In Progress
- [ ] **Enhanced Error Handling** - Flow-based retry logic and fallback mechanisms
- [ ] **Universal Provider Flow Enhancement** - Creating a open flow to support any providers out-of-the-box
- [ ] **Parallel Tools Calls** - Enable parallel tools calls handling

### 📒 Tech Debts
- [ ] **Enhanced CMDT Management** – Update custom metadata types accordingly with custom object updates

### 🚀 Future Vision
- [ ] **Flow Template Library** - Pre-built agentic flow patterns that require zero Apex
- [ ] **Multi-Agent Orchestration** - Coordinate multiple AI agents within flows
- [ ] **Conversational Memory** - Maintain context across flow executions outside the OpenAI response endpoint
- [ ] **Flow Analytics Dashboard** - Monitor AI usage and performance
- [ ] **RAG Implementation** - Retrieval-augmented generation using Salesforce data
- [ ] **Custom Tool Creation UI** - Visual builder for AI function definitions
- [ ] **Batch Processing Support** - Handle bulk operations with AI
- [ ] **Vector Database Integration** - Semantic search capabilities

## 📁 Project Structure(Being Used)
```
mrflow/
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/                        # Apex utilities and handlers
│           ├── flows/                          # Pre-built flows and orchestrators
│           ├── customMetadata/                 # AI conductor configurations
│           ├── externalCredentials/            # External credentials for External Services
│           └── namedCredentials/               # Named Credentials
│           └── externalServiceRegistrations/   # External services
│           └── permissionsets/                 # Permission sets
```

## 📚 Documentation

- Getting Started Guide - Coming soon
- API Reference - Coming soon
- Flow Templates - Coming soon
- Video Tutorials - Coming soon
- Best Practices - Coming soon

## 🙏 Acknowledgments

This project is a passion effort to democratize AI in Salesforce. Special thanks to:
- The Salesforce developer community for inspiration and feedback
- Open-source contributors who make projects like this possible

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Community & Support

- **Issues and Requests**: [GitHub Issues](https://github.com/mrhewbuc/mrflow/issues)

## 🌟 Star Us!

If MrFlow helps your organization, please consider giving us a star ⭐ on GitHub. It helps others discover the project and motivates us to keep improving!

---

**Built with ❤️ for the Salesforce community** - Making AI-powered automation accessible to everyone.
