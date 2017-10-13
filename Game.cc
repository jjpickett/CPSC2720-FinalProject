#include "Game.h"

SDL_Texture* tempTexture;
SDL_Rect srcR, destR;

Game::Game()
{
}


Game::~Game()
{
}

void Game::init(const char * title, int xPos, int yPos, int width, int height, bool fullscreen)
{
	int flags = 0;

	if (fullscreen)
	{
		flags = SDL_WINDOW_FULLSCREEN;
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) == 0)
	{
		std::cout << "Subsystem has beeen initialised..." << std::endl;

		window = SDL_CreateWindow(title, xPos, yPos, width, height, flags);

		if (window) 
		{
			std::cout << "Window has been created!" << std::endl;
		}

		renderer = SDL_CreateRenderer(window, -1, 0);

		if (renderer)
		{
			SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
			std::cout << "Renderer has been created!" << std::endl;
		}

		isRunning = true;
	}
	else
	{
		isRunning = false;
	}


	//Always need a surface?
	SDL_Surface* tmpSurface = IMG_Load("assets/113.png");
	tempTexture = SDL_CreateTextureFromSurface(renderer, tmpSurface);
	SDL_FreeSurface(tmpSurface);
}

void Game::eventHandler()
{
	SDL_Event event;
	SDL_PollEvent(&event);

	switch (event.type)
	{
	case SDL_QUIT:
		isRunning = false;
		break;

	default:
		break;

	}
}

void Game::update()
{
	destR.h = 303;
	destR.w = 200;
}

void Game::render()
{
	SDL_RenderClear(renderer);
	//this is where we will add stuff to render
	SDL_RenderCopy(renderer, tempTexture, NULL, &destR);
	SDL_RenderPresent(renderer);
}

void Game::clean()
{
	//Free loaded image
	SDL_DestroyTexture(tempTexture);
	tempTexture = NULL;
	
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	window = NULL;
	renderer = NULL;

	
	
	IMG_Quit();
	SDL_Quit();

	std::cout << "Game Cleaned!" << std::endl;
}

bool Game::running()
{
	return isRunning;
}
