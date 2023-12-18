//
//  CustomView.swift
//  Maraphon_7
//
//  Created by Evgeny Evtushenko on 17/12/2023.
//

import SwiftUI

struct CustomView<Content: View>: View {
    private let collapsedSize: CGSize = .init(width: 80, height: 50)
    private let expandexSize: CGSize = .init(width: 250, height: 300)
    
    @State private var isCollapsed: Bool = true
    @Namespace private var ns
    
    let content: Content
    
    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if isCollapsed {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isCollapsed.toggle()
                        }
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.blue)
                            .matchedGeometryEffect(id: "Background", in: ns)
                            .frame(width: isCollapsed ? collapsedSize.width : expandexSize.width, height: isCollapsed ? collapsedSize.height : expandexSize.height)
                            .padding(10)
                            .overlay {
                                Text("Open")
                                    .matchedGeometryEffect(id: "Text", in: ns, properties: .position, anchor: .leading)
                                    .foregroundStyle(.white)
                            }
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.blue)
                    .matchedGeometryEffect(id: "Background", in: ns)
                    .frame(width: !isCollapsed ? expandexSize.width : collapsedSize.width, height: !isCollapsed ? expandexSize.height : collapsedSize.height)
                
                VStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isCollapsed.toggle()
                        }
                    }, label: {
                        Text("\(Image(systemName: "arrowshape.backward.fill")) Close")
                            .matchedGeometryEffect(id: "Text", in: ns, properties: .position, anchor: .leading)
                            .foregroundStyle(.white)
                            .padding(10)
                    })
                 
                    content
                }
            }
        }
    }
}

#Preview {
    CustomView {
        EmptyView()
    }
}
