AbstractButton { 
                id: root; 
                property var cardData;
                property string backgroundShapeStyle: "inset"; 
                property real fontScale: 1.0; 
                property var scopeStyle: null; 
                readonly property string title: cardData && cardData["title"] || "";
                property bool showHeader: true;
                implicitWidth: childrenRect.width;
                enabled: true;
                property int fixedHeaderHeight: -1; 
                property size fixedArtShapeSize: Qt.size(-1, -1); 
signal action(var actionId);
Loader {
                                id: backgroundLoader; 
                                objectName: "backgroundLoader"; 
                                anchors.fill: parent; 
                                asynchronous: true;
                                visible: status == Loader.Ready; 
                                sourceComponent: UbuntuShape { 
                                    objectName: "background"; 
                                    radius: "medium"; 
                                    aspect: { 
                                        switch (root.backgroundShapeStyle) { 
                                            case "inset": return UbuntuShape.Inset; 
                                            case "shadow": return UbuntuShape.DropShadow; 
                                            default: 
                                            case "flat": return UbuntuShape.Flat; 
                                        } 
                                    } 
                                    backgroundColor: getColor(0) || "white"; 
                                    secondaryBackgroundColor: getColor(1) || backgroundColor; 
                                    backgroundMode: UbuntuShape.VerticalGradient;
                                    anchors.fill: parent; 
                                    source: backgroundImage.source ? backgroundImage : null; 
                                    property real luminance: Style.luminance(backgroundColor); 
                                    property Image backgroundImage: Image { 
                                        objectName: "backgroundImage"; 
                                        source: { 
                                            if (cardData && typeof cardData["background"] === "string") return cardData["background"]; 
                                            else return ""; 
                                        } 
                                    } 
                                    function getColor(index) { 
                                        if (cardData && typeof cardData["background"] === "object" 
                                            && (cardData["background"]["type"] === "color" || cardData["background"]["type"] === "gradient")) { 
                                            return cardData["background"]["elements"][index]; 
                                        } else return index === 0 ? "#E9E9E9" : "#E9AAE9"; 
                                    } 
                                } 
                            }
readonly property int headerHeight: row.height;
Row { 
                        id: row; 
                        objectName: "outerRow"; 
                        property real margins: units.gu(1); 
                        spacing: margins; 
                        height: root.fixedHeaderHeight;
                        anchors { top: parent.top; 
                                     topMargin: units.gu(1);
left: parent.left;
 } 
                        anchors.right: parent.right; 
                        anchors.margins: margins; 
                        anchors.rightMargin: 0; 
                        data: [ 
                                CroppedImageMinimumSourceSize { 
                            id: mascotImage; 
                            objectName: "mascotImage"; 
                            anchors { verticalCenter: parent.verticalCenter; } 
                            source: cardData && cardData["mascot"] || ""; 
                            width: units.gu(6); 
                            height: units.gu(5.625); 
                            horizontalAlignment: Image.AlignHCenter; 
                            verticalAlignment: Image.AlignVCenter; 
                            visible: showHeader; 
                        }
,Label { 
                        id: titleLabel; 
                        objectName: "titleLabel"; 
                        anchors { verticalCenter: parent.verticalCenter;
 } 
                        elide: Text.ElideRight; 
                        fontSize: "small"; 
                        wrapMode: Text.Wrap; 
                        maximumLineCount: 2; 
                        font.pixelSize: Math.round(FontUtils.sizeToPixels(fontSize) * fontScale); 
                        color: backgroundLoader.active && backgroundLoader.item && root.scopeStyle ? root.scopeStyle.getTextColor(backgroundLoader.item.luminance) : (backgroundLoader.item && backgroundLoader.item.luminance > 0.7 ? theme.palette.normal.baseText : "white"); 
                        visible: showHeader ; 
                        width: parent.width - x; 
                        text: root.title; 
                        font.weight: cardData && cardData["subtitle"] ? Font.DemiBold : Font.Normal; 
                        horizontalAlignment: Text.AlignLeft;
                    }
 
                                ] 
                    }
UbuntuShape { 
    id: touchdown;
    objectName: "touchdown";
    anchors { fill: backgroundLoader }
    visible: root.pressed;
    radius: "medium";
    borderSource: "radius_pressed.sci"
}
implicitHeight: row.y + row.height + units.gu(1);
}
