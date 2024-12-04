import Foundation
import UIKit

/// Une classe utilitaire pour gérer les actions liées au presse-papiers.
class ClipboardHelper {
    /// Copie une chaîne de caractères dans le presse-papiers.
    ///
    /// - Parameter text: Le texte à copier dans le presse-papiers.
    static func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}
