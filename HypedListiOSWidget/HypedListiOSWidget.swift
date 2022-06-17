//
//  HypedListiOSWidget.swift
//  HypedListiOSWidget
//
//  Created by Bikram Aryal on 17/06/2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> HypedEventEntry {
        HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1)
    }

    func getSnapshot(in context: Context, completion: @escaping (HypedEventEntry) -> ()) {
        let entry = HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [HypedEventEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = HypedEventEntry(date: entryDate, hypedEvent: testHypedEvent1)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct HypedEventEntry: TimelineEntry {
    let date: Date
    let hypedEvent: HypedEvent?
}

struct HypedListiOSWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        
        GeometryReader { geometry in
        
        
        
        if entry.hypedEvent != nil
            
        {
            ZStack {
            if entry.hypedEvent!.image() != nil {
                entry.hypedEvent!.image()!.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
            } else {
                entry.hypedEvent?.color
            }
                
                Color.black.opacity(0.1)
                
                Text(entry.hypedEvent!.title)
                    .foregroundColor(.white)
                    .font(fontSize())
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(fontSize())
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                    Text(entry.hypedEvent!.timeFromNow())
                            .bold()
                            .padding(10)
                            .foregroundColor(.white)
                            
                          
                    }
                    
                    
                }
            }
            
        } else {
            VStack(alignment: .center) {
                Spacer()
            Text("No events upcoming. Tap me to add something")
                .padding()
                .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        }
    }
    
    
    func fontSize() -> Font {
        switch widgetFamily {
        case .systemSmall:
            return .body
        
        case .systemMedium:
            return .title2
        
        case .systemLarge:
            return .title
        case .systemExtraLarge:
            return .largeTitle
        
        @unknown default:
            return .body
    }
    }
}

@main
struct HypedListiOSWidget: Widget {
    let kind: String = "HypedListiOSWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HypedListiOSWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct HypedListiOSWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            
            HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                
                HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
                    .previewContext(WidgetPreviewContext(family: .systemMedium))
                
                HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
                    .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            
            HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                
                HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
                    .previewContext(WidgetPreviewContext(family: .systemMedium))
                
                HypedListiOSWidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
                    .previewContext(WidgetPreviewContext(family: .systemLarge))
            
        }
    }
}
