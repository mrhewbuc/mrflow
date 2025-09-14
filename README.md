# MrFlow - Agentic Flows for Salesforce

> 🚀 **Bringing AI-powered automation to Salesforce without AgentForce** - An open-source passion project empowering developers and SMBs with intelligent flow orchestration.

[![Salesforce API](https://img.shields.io/badge/Salesforce%20API-v64.0-blue)](https://developer.salesforce.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Package Version](https://img.shields.io/badge/Package-v0.1.0--NEXT-orange)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tJ8000000xA9WIAU)

## 🎯 Vision

MrFlow democratizes AI-powered automation in Salesforce by providing "Agentic" Flow capabilities without requiring expensive AgentForce licenses. Built as a passion project for the Salesforce community, we're making intelligent automation accessible to developers and small-to-medium businesses who need sophisticated flow orchestration without enterprise costs.

### 🏗️ Architecture Philosophy

**Flow-First, Code-Minimal**: We believe in maximizing declarative development. While some Apex is necessary for advanced functionality, our goal is to empower admins and developers to build AI-powered automation primarily through Flows, keeping the codebase lean and maintainable.

## ✨ Why MrFlow?

- **🆓 Open Source**: Full transparency and community-driven development
- **📦 Easy Installation**: Available as a managed package for quick deployment
- **🤖 AI-Native**: Built-in OpenAI and Claude integration for intelligent decision-making
- **⚡ Async by Design**: Non-blocking flow execution prevents governor limits
- **🔧 Developer-Friendly**: Extensible architecture for custom implementations
- **💼 SMB-Focused**: Affordable AI automation for growing businesses

## 🚀 Quick Start

### Install via Package

Install the latest version directly in your Salesforce org:

**Production/Developer Edition:**
```
https://login.salesforce.com/packaging/installPackage.apexp?p0=04tJ8000000xA9WIAU
```

**Sandbox:**
```
https://test.salesforce.com/packaging/installPackage.apexp?p0=04tJ8000000xA9WIAU
```

### Install from Source

1. Clone the repository:
```bash
git clone https://github.com/yourusername/mrflow.git
cd mrflow
```

2. Authorize your org:
```bash
sf org login web --set-default-dev-hub --alias myorg
```

3. Create a scratch org (optional):
```bash
sf org create scratch -f config/project-scratch-def.json --alias mrflow-scratch --set-default
```

4. Deploy the source:
```bash
sf project deploy start
```

5. Assign permission set:
```bash
sf org assign permset --name mf_openai
```

## 🎨 Current Features

### ✅ Available Now

#### 🤖 AI Integration Layer
- **OpenAI GPT Integration**: Connect flows to GPT-4o and GPT-4o-mini models
- **Claude Integration**: Support for Claude 3.5 Haiku and Sonnet models
- **Tool Object Handling**: Serialize/deserialize AI function calls within flows
- **External Service Framework**: Robust API integration with error handling

#### ⚡ Flow-Based AI Orchestration
- **Dedicated OpenAI Response Flow**: Specialized flow (`OpenAI_Async_Call_Response_Endpoint`) exclusively handles OpenAI responses with built-in error handling and routing
- **Universal AI Provider Flow**: Open architecture flow that works with ANY AI provider (OpenAI, Anthropic, Google, Cohere, etc.) - bring your own API
- **Async Flow Execution**: Run flows in the background without blocking users
- **Minimal Apex Footprint**: Strategic use of Apex only where necessary - most logic lives in Flows
- **Platform Event Architecture**: Decouple flow components for better scalability

#### 🎛️ Metadata-Driven Configuration
- **AI Conductor Settings**: Configure AI models via custom metadata
- **No-Code Model Switching**: Change AI providers without touching code
- **Pre-configured Models**: Ready-to-use configurations for popular AI models

#### 📧 Intelligent Automation Patterns
- **Smart Email Routing**: AI-powered email classification and routing
- **Asset Management**: Intelligent asset tracking and decision flows
- **Response Generation**: Automated response creation using AI
- **Provider Flexibility**: Switch between AI providers without code changes - just update Flow configurations

## 🔄 Dual-Flow Architecture

MrFlow implements a unique dual-flow pattern for maximum flexibility:

### 1️⃣ OpenAI Response Endpoint Flow
A dedicated, optimized flow specifically for OpenAI integration:
- Pre-configured for GPT models
- Built-in OpenAI-specific error handling
- Streamlined token management
- Direct integration with OpenAI's function calling

### 2️⃣ Universal AI Provider Flow
An open, flexible flow that works with ANY AI provider:
- Bring Your Own AI (BYOAI) - use any provider with REST APIs
- Provider-agnostic design
- Custom authentication support
- Standardized request/response handling
- Perfect for: Anthropic, Google Vertex AI, Cohere, Hugging Face, local LLMs

**Why Two Flows?**
- **Optimization**: OpenAI flow is fine-tuned for OpenAI's specific requirements
- **Flexibility**: Universal flow ensures you're never locked into one provider
- **Simplicity**: Choose the right tool for your use case
- **Future-Proof**: Easy to add new providers without touching Apex code

## 🗺️ Roadmap

### 🔄 In Progress
- [ ] **Universal Provider Flow Enhancement** - Expanding the open flow to support more AI providers out-of-the-box
- [ ] **Flow Template Library** - Pre-built agentic flow patterns that require zero Apex
- [ ] **Enhanced Error Handling** - Flow-based retry logic and fallback mechanisms
- [ ] **Provider Response Standardization** - Common response format across all AI providers

### 📅 Q1 2025
- [ ] **Multi-Agent Orchestration** - Coordinate multiple AI agents within flows
- [ ] **Conversational Memory** - Maintain context across flow executions
- [ ] **Local LLM Support** - Integration with self-hosted models
- [ ] **Flow Analytics Dashboard** - Monitor AI usage and performance

### 🔮 Q2 2025
- [ ] **RAG Implementation** - Retrieval-augmented generation using Salesforce data
- [ ] **Custom Tool Creation UI** - Visual builder for AI function definitions
- [ ] **Cost Optimization Engine** - Smart routing between AI providers based on cost
- [ ] **Batch Processing Support** - Handle bulk operations with AI

### 🚀 Future Vision
- [ ] **Vector Database Integration** - Semantic search capabilities
- [ ] **Fine-tuning Pipeline** - Custom model training on org data
- [ ] **Agent Marketplace** - Share and discover community-built agents
- [ ] **Natural Language Flow Builder** - Create flows using plain English

## 🛠️ Development

### Prerequisites for Package Installation
- Salesforce org (Production, Sandbox, or Developer Edition)
- System Administrator profile or appropriate permissions

### For Contributors & Developers Only

If you're contributing to the codebase, you'll also need:
- Salesforce CLI
- Node.js 18+ (for development only)
- VS Code with Salesforce Extensions

**Development Setup:**

1. Install dependencies:
```bash
npm install
```

2. Run tests:
```bash
npm test
```

3. Format code:
```bash
npm run prettier
```

4. Lint:
```bash
npm run lint
```

### Project Structure
```
mrflow/
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/          # Apex utilities and handlers
│           ├── flows/            # Agentic flow definitions
│           ├── customMetadata/   # AI conductor configurations
│           └── objects/          # Custom objects and events
├── config/                       # Scratch org definitions
├── .claude/                      # Claude Code documentation
└── manifest/                     # Package manifests
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
- SMBs and developers looking for affordable AI solutions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Community & Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/mrflow/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/mrflow/discussions)
- **Email**: mrflow@yourdomain.com

## 🌟 Star Us!

If MrFlow helps your organization, please consider giving us a star ⭐ on GitHub. It helps others discover the project and motivates us to keep improving!

---

**Built with ❤️ for the Salesforce community** - Making AI-powered automation accessible to everyone.