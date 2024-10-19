//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @ObservedResults(Event.self) private var allEvents
    @Environment(\.dismiss) var dismiss
    @Environment(AlertManager.self) private var alertManager
    @State var viewModel: EventInfoScreenViewModel
	let notificationManager: NotificationManager
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, content: {
            GroupBox() {
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, content: {
                        Text(viewModel.event.title)
                            .font(.title2)
                        Text(viewModel.event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Divider()
                            .frame(width: Constraints.dividerWidth)
                        Text(viewModel.info)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        Text(viewModel.localizedTimeState)
                            .font(.subheadline)
                        Divider()
                        ForEach(viewModel.allDateTypes, id: \.self) { dateTypeKey in
                            if let number = viewModel.allInfoForCurrentDate?[dateTypeKey] {
                                DateInfoView(number: number, dateType: dateTypeKey, viewModel: viewModel)
                            }
                        }
                    }
                    .frame(width: Constraints.eventDateTableSize)
					.shadow(color: .secondary, radius: 1)
                })
            }
			if let image = viewModel.event.imageData {
				GroupBox {
					Button { 
						viewModel.overlay = Image(uiImage: UIImage(data: image)!)
					} label: { 
						Image(uiImage: UIImage(data: image)!)
							.resizable()
							.clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
							.padding()
							.aspectRatio(contentMode: ContentMode.fit)
							.shadow(color: .black, radius: Constraints.shadowRadius, y: Constraints.shadowRadius)
					}
				}
			}
            Spacer()
        })
        .padding()
        // MARK: - View settings
        .navigationTitle("details".localized)
        .toolbarBackground(viewModel.event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
		.toolbar(viewModel.toolBarVisibility)
        .sheet(isPresented: $viewModel.editSheetIsOpened, onDismiss: {
            withAnimation {
                viewModel.updateEditedEventOnDismiss(completion: { result in
                    alertManager.getIdentifiebleErrorFrom(result: result)
                })
            }
            WidgetManager.sendToOtherTargetsThis(Array(allEvents), completion: { result in
                alertManager.getIdentifiebleErrorFrom(result: result)
            })
        }, content: {
            AddOrEditEventSheet(event: viewModel.event,
                                isOpened: $viewModel.editSheetIsOpened,
								screenMode: .edit,
								notificationManager: notificationManager)
            .interactiveDismissDisabled()
        })
        .sheet(isPresented: $viewModel.notificationSheetIsOpened, content: {
			NotificationSetupView(event: viewModel.event,
								  notificationManager: notificationManager)
                .presentationDetents([.height(Constraints.notificationSetupViewHeight)])
        })
		.overlay(content: { 
			ImageOverlayView()
		})
        .toolbar(content: {
            backButton
            notificationSettingsButton
            editButton
        })
        .tint(viewModel.event.color)
		.environment(viewModel)
    }

	init(event: Event, notificationManager: NotificationManager) {
        self.viewModel = EventInfoScreenViewModel(event: event)
		self.notificationManager = notificationManager
    }
}
