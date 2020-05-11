//
// MyCustomSoundClassifier.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
class MyCustomSoundClassifierInput : MLFeatureProvider {

    /// Input audio features as 15600 element vector of floats
    var audio: MLMultiArray

    var featureNames: Set<String> {
        get {
            return ["audio"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "audio") {
            return MLFeatureValue(multiArray: audio)
        }
        return nil
    }
    
    init(audio: MLMultiArray) {
        self.audio = audio
    }
}

/// Model Prediction Output Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
class MyCustomSoundClassifierOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// Prediction probabilities as dictionary of strings to doubles
    lazy var categoryProbability: [String : Double] = {
        [unowned self] in return self.provider.featureValue(for: "categoryProbability")!.dictionaryValue as! [String : Double]
    }()

    /// Class label of top prediction as string value
    lazy var category: String = {
        [unowned self] in return self.provider.featureValue(for: "category")!.stringValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(categoryProbability: [String : Double], category: String) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["categoryProbability" : MLFeatureValue(dictionary: categoryProbability as [AnyHashable : NSNumber]), "category" : MLFeatureValue(string: category)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
class MyCustomSoundClassifier {
    var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: MyCustomSoundClassifier.self)
        return bundle.url(forResource: "MyCustomSoundClassifier", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration
        - parameters:
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct a model with explicit path to mlmodelc file and configuration
        - parameters:
           - url: the file url of the model
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as MyCustomSoundClassifierInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MyCustomSoundClassifierOutput
    */
    func prediction(input: MyCustomSoundClassifierInput) throws -> MyCustomSoundClassifierOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as MyCustomSoundClassifierInput
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MyCustomSoundClassifierOutput
    */
    func prediction(input: MyCustomSoundClassifierInput, options: MLPredictionOptions) throws -> MyCustomSoundClassifierOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return MyCustomSoundClassifierOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - audio: Input audio features as 15600 element vector of floats
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MyCustomSoundClassifierOutput
    */
    func prediction(audio: MLMultiArray) throws -> MyCustomSoundClassifierOutput {
        let input_ = MyCustomSoundClassifierInput(audio: audio)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [MyCustomSoundClassifierInput]
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [MyCustomSoundClassifierOutput]
    */
    func predictions(inputs: [MyCustomSoundClassifierInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [MyCustomSoundClassifierOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [MyCustomSoundClassifierOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  MyCustomSoundClassifierOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
