# WeatherClothingApp

### Getting Your API Key
This app uses OpenWeatherMap to get weather data. It’s free, but you need to sign-up to get an API key. Head over there, and sign up. Once you get to your dashboard, click on the API keys tab. There you’ll find your API key. Add your API key to the Xcode project accordingly. 

In WeatherAPI.swift change the `getAPIKey()` function so that it looks like this:

    func getAPIKey() -> String? {
        return YOUR_API_KEY_HERE
    }
    

