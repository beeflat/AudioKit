// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AudioKit version of Apple's BandPassFilter Audio Unit
///
open class BandPassFilter: NodeBase, Toggleable {

    fileprivate let effectAU = AVAudioUnitEffect(
    audioComponentDescription:
    AudioComponentDescription(appleEffect: kAudioUnitSubType_BandPassFilter))

    let input: Node
    override public var connections: [Node] { [input] }

    /// Specification details for centerFrequency
    public static let centerFrequencyDef = NodeParameterDef(
        identifier: "centerFrequency",
        name: "Center Frequency",
        address: 0,
        defaultValue: 5000,
        range: 20 ... 22050,
        unit: .hertz,
        flags: .default)

    /// Center Frequency (Hertz) ranges from 20 to 22050 (Default: 5000)
    @Parameter(centerFrequencyDef) public var centerFrequency: AUValue

    /// Specification details for bandwidth
    public static let bandwidthDef = NodeParameterDef(
        identifier: "bandwidth",
        name: "Bandwidth",
        address: 1,
        defaultValue: 600,
        range: 100 ... 12000,
        unit: .cents,
        flags: .default)

    /// Bandwidth (Cents) ranges from 100 to 12000 (Default: 600)
    @Parameter(bandwidthDef) public var bandwidth: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the band pass filter node
    ///
    /// - parameter input: Input node to process
    /// - parameter centerFrequency: Center Frequency (Hertz) ranges from 20 to 22050 (Default: 5000)
    /// - parameter bandwidth: Bandwidth (Cents) ranges from 100 to 12000 (Default: 600)
    ///
    public init(
        _ input: Node,
        centerFrequency: AUValue = centerFrequencyDef.defaultValue,
        bandwidth: AUValue = bandwidthDef.defaultValue) {
        self.input = input
        super.init(avAudioNode: effectAU)

        associateParams(with: effectAU)

        self.centerFrequency = centerFrequency
        self.bandwidth = bandwidth
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
