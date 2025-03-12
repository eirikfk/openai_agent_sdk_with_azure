# OpenAI Agent SDK using local and Azure deployed LLMs

## Introduction

This is a repository which shows how to use the Agent SDK with models local models or models deployed to Azure. The Agent SDK requires a model which support structured output. For more info :

- [Details for Azure](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/structured-outputs?tabs=python-secure%2Cdotnet-entra-id&pivots=programming-language-python)
- [Details for Ollama](https://ollama.com/search?c=tools)

## Setup

The repository is configured with a VsCode devcontainer with all necessary dependencies installed, and Poetry will install necessary Python dependencies.

### Prerequisites

- Docker
- [Azure] Model deployed to Azure that supports tool usage.
- [Ollama] Ollama installed and a model running on your computer that supports tool usage.
  - How to install, run and pull models using [Ollama.](https://github.com/ollama/ollama/blob/main/README.md#quickstart)

### Tasks

1. Make sure you select the poetry python environment prefixed with `openai-agent`.
2. Create a .env file in the root-folder based on the structure shown in .env_example

## Known challenges

- The Agent SDK assume the model is named 'gpt-4o' if not otherwise instructed.
