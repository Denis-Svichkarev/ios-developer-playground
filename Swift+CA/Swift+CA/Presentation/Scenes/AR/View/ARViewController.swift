//
//  ARViewController.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 30/11/24.
//

import UIKit
import ARKit
import RealityKit

final class ARViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var arView: ARView!
    
    // MARK: - Properties
    private let viewModel: ARViewModel
    weak var coordinator: AppCoordinator?
    private var coachingOverlay: ARCoachingOverlayView!
    
    // MARK: - Initialization
    init(viewModel: ARViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ARViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAR()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startARSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = viewModel.furnitureItem.name
        
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setupAR() {
        arView.automaticallyConfigureSession = false
        arView.debugOptions = [.showSceneUnderstanding]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(tapGesture)
    }
    
    private func setupCoachingOverlay() {
        coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = arView.session
        coachingOverlay.delegate = self
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        coachingOverlay.goal = .horizontalPlane
        
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func startARSession() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.delegate = self
        arView.session.run(config)
        print("✅ AR Session started")
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        coordinator?.dismissAR()
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        print("🟦 Tap detected at location: \(location)")
        
        let results = arView.raycast(
            from: location,
            allowing: .estimatedPlane,
            alignment: .any
        )
        
        if let firstResult = results.first {
            print("✅ Raycast result found, placing furniture")
            placeFurniture(at: firstResult)
        } else {
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.notificationOccurred(.error)
            
            let alert = UIAlertController(
                title: "Cannot Place Object",
                message: "Try pointing at a flat surface",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            print("❌ No raycast result found")
        }
    }
    
    // MARK: - Private Methods
    private func placeFurniture(at raycastResult: ARRaycastResult) {
        do {
            print("⏳ Starting to load model")
            let model = try viewModel.loadModel()
            
            let anchor = AnchorEntity(world: raycastResult.worldTransform)
            anchor.addChild(model)
            
            arView.scene.addAnchor(anchor)
            print("✅ Model placed in scene")
        } catch {
            print("❌ Failed to load model: \(error)")
        }
    }
}

// MARK: - ARSessionDelegate
extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("❌ AR Session failed with error: \(error)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("⚠️ AR Session was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("✅ AR Session interruption ended")
    }
}

// MARK: - ARCoachingOverlayViewDelegate
extension ARViewController: ARCoachingOverlayViewDelegate {
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {}
}
