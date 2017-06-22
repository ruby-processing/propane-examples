// Daniel Shiffman
// The Nature of Code, Fall 2006
// Neural Network

// Class to describe the entire network
// Arrays for input neurons, hidden neurons, and output neuron

// Need to update this so that it would work with an array out outputs
// Rather silly that I didn't do this initially

// Also need to build in a "Layer" class so that there can easily
// be more than one hidden layer

package nn;

import java.util.ArrayList;

public class Network {

    // Layers
    InputNeuron[] input;
    HiddenNeuron[] hidden;
    OutputNeuron output;
    
    public static final double LEARNING_CONSTANT = 0.5;

    // Only One output now to start!!! (i can do better, really. . .)
    // Constructor makes the entire network based on number of inputs & number of neurons in hidden layer
    // Only One hidden layer!!!  (fix this dood)

    public Network(int inputs, int hiddentotal) {

        input = new InputNeuron[inputs+1];  // Got to add a bias input
        hidden = new HiddenNeuron[hiddentotal+1];

        // Make input neurons
        for (int i = 0; i < input.length-1; i++) {
            input[i] = new InputNeuron();
        }
        
        // Make hidden neurons
        for (int i = 0; i < hidden.length-1; i++) {
            hidden[i] = new HiddenNeuron();
        }

        // Make bias neurons
        input[input.length-1] = new InputNeuron(1);
        hidden[hidden.length-1] = new HiddenNeuron(1);

        // Make output neuron
        output = new OutputNeuron();

        // Connect input layer to hidden layer
        for (InputNeuron input1 : input) {
            for (int j = 0; j < hidden.length-1; j++) {
                // Create the connection object and put it in both neurons
                Connection c = new Connection(input1, hidden[j]);
                input1.addConnection(c);
                hidden[j].addConnection(c);
            }
        }
        
        // Connect the hidden layer to the output neuron
        for (HiddenNeuron hidden1 : hidden) {
            Connection c = new Connection(hidden1, output);
            hidden1.addConnection(c);
            output.addConnection(c);
        }

    }


    public double feedForward(double[] inputVals) {
        
        // Feed the input with an array of inputs
        for (int i = 0; i < inputVals.length; i++) {
            input[i].input(inputVals[i]);  
        }
        
        // Have the hidden layer calculate its output
        for (int i = 0; i < hidden.length-1; i++) {
            hidden[i].calcOutput();
        }

        // Calculate the output of the output neuron
        output.calcOutput();
        
        // Return output
        return output.output();
    }

    public double train(double[] inputs, double answer) {
        double result = feedForward(inputs);
        
        
        // This is where the error correction all starts
        // Derivative of sigmoid output function * diff between known and guess
        double deltaOutput = result*(1-result) * (answer-result);

        
        // BACKPROPOGATION
        // This is easier b/c we just have one output
        // Apply Delta to connections between hidden and output
        ArrayList<Connection> connections = output.getConnections();
        for (int i = 0; i < connections.size(); i++) {
            Connection c = connections.get(i);
            Neuron neuron = c.from();
            double loutput = neuron.output();
            double deltaWeight = loutput*deltaOutput;
            c.adjustWeight(LEARNING_CONSTANT*deltaWeight);
        }
        
        // ADJUST HIDDEN WEIGHTS
        for (HiddenNeuron hidden1 : hidden) {
            connections = hidden1.getConnections();
            double sum  = 0;
            // Sum output delta * hidden layer connections (just one output)
            for (int j = 0; j < connections.size(); j++) {
                Connection c = connections.get(j);
                // Is this a connection from hidden layer to next layer (output)?
                if (c.from() == hidden1) {
                    sum += c.weight()*deltaOutput;
                }
            }    
            // Then adjust the weights coming in based:
            // Above sum * derivative of sigmoid output function for hidden neurons
            for (int j = 0; j < connections.size(); j++) {
                Connection c = connections.get(j);
                // Is this a connection from previous layer (input) to hidden layer?
                if (c.to() == hidden1) {
                    double loutput = hidden1.output();
                    double deltaHidden = loutput * (1 - loutput);  // Derivative of sigmoid(x)
                    deltaHidden *= sum;   // Would sum for all outputs if more than one output
                    Neuron neuron = c.from();
                    double deltaWeight = neuron.output() * deltaHidden;
                    c.adjustWeight(LEARNING_CONSTANT * deltaWeight);
                }
            } 
        }

        return result;
    }
}
