//
//  FactoryEx2.swift
//  
//
//  Created by Damir Aliyev on 25.02.2023.
//


class Content {
    let contentDescription: String
    
    init(contentDescription: String) {
        self.contentDescription = contentDescription
    }
}

protocol Data {
    var type: String {get}
    var content: Content {get}
}


class TextData: Data {
    var type: String = "Text"
    var content: Content = Content(contentDescription: "Text content")
}


class AudioData: Data {
    var type: String = "Audio"
    var content: Content = Content(contentDescription: "Audio content")
}

class VideoData: Data {
    var type: String = "Video"
    
    var content: Content = Content(contentDescription: "Video content")
}

protocol DataProcessor {
    func processData(data: Data) -> Data
}

class TextDataProcessor: DataProcessor {
    func processData(data: Data) -> Data {
        print("Processing text data")
        return TextData()
    }
}


class AudioDataProcessor: DataProcessor {
    func processData(data: Data) -> Data {
        print("Processing audio data")
        return AudioData()
    }
}

class VideoDataProcessor: DataProcessor {
    func processData(data: Data) -> Data {
        print("Processing video data")
        return VideoData()
    }
}

class DataProcessorCreator {
    private var dataProcessor: DataProcessor
    
    init(dataProcessor: DataProcessor) {
        self.dataProcessor = dataProcessor
    }
    
    func setProcessor(dataProcessor: DataProcessor) {
        self.dataProcessor = dataProcessor
    }
    
    func processData(data: Data) -> Data {
       return dataProcessor.processData(data: data)
    }
}

let textDataProcessor = TextDataProcessor()

let creator = DataProcessorCreator(dataProcessor: textDataProcessor)

let textData = creator.processData(data: TextData())

let audioDataProcessor = AudioDataProcessor()

creator.setProcessor(dataProcessor: audioDataProcessor)
let audioData = creator.processData(data: AudioData())

let videoDataProcessor = VideoDataProcessor()

creator.setProcessor(dataProcessor: videoDataProcessor)
let videoData = creator.processData(data: VideoData())



