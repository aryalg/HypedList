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

    var body: some View {
        if entry.hypedEvent != nil
        {
            if entry.hypedEvent!.image() != nil {
                entry.hypedEvent!.image()
            } else {
                entry.hypedEvent?.color
            }
            
        } else {
            Text("No events upcoming. Tap me to add something")
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
