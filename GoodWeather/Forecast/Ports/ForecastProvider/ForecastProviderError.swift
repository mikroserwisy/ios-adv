enum ForecastProviderError: Error {
    
    case error(String)
    case invalidRequestUrl
    case requestFailed(Int)
    case invalidResponseData
    case parsingFailed(String)
    
}
