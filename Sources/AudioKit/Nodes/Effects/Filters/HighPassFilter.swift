// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AudioKit version of Apple's HighPassFilter Audio Unit
///
open class HighPassFilter: NodeBase, Toggleable {

    fileprivate let effectAU = AVAudioUnitEffect(
    audioComponentDescription:
    AudioComponentDescription(appleEffect: kAudioUnitSubType_HighPassFilter))

    let input: Node
    override public var connections: [Node] { [input] }

    /// Specification details for cutoffFrequency
    public static let cutoffFrequencyDef = NodeParameterDef(
        identifier: "cutoffFrequency",
        name: "Cutoff Frequency",
        address: 0,
        defaultValue: 6900,
        range: 10 ... 22050,
        unit: .hertz,
        flags: .default)

    /// Cutoff Frequency (Hertz) ranges from 10 to 22050 (Default: 6900)
    @Parameter(cutoffFrequencyDef) public var cutoffFrequency: AUValue

    /// Specification details for resonance
    public static let resonanceDef = NodeParameterDef(
        identifier: "resonance",
        name: "Resonance",
        address: 1,
        defaultValue: 0,
        range: -20 ... 40,
        unit: .decibels,
        flags: .default)

    /// Resonance (decibels) ranges from -20 to 40 (Default: 0)
    @Parameter(resonanceDef) public var resonance: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the high pass filter node
    ///
    /// - parameter input: Input node to process
    /// - parameter cutoffFrequency: Cutoff Frequency (Hertz) ranges from 10 to 22050 (Default: 6900)
    /// - parameter resonance: Resonance (decibels) ranges from -20 to 40 (Default: 0)
    ///
    public init(
        _ input: Node,
        cutoffFrequency: AUValue = cutoffFrequencyDef.defaultValue,
        resonance: AUValue = resonanceDef.defaultValue) {
        self.input = input
        super.init(avAudioNode: effectAU)

        associateParams(with: effectAU)

        self.cutoffFrequency = cutoffFrequency
        self.resonance = resonance
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
