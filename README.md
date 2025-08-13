DLCV Final Project ( Multiple Concept Personalization )

# Usage
To start working on this project, you should clone this repository into your local machine by using the following command.
```bash
git clone https://github.com/DLCV-Fall-2024/DLCV-Fall-2024-Final-2-acl.git
```
# Environment Setup
This work should be completed using Python 3.9.21. Create a environment under conda
```bash
conda create -n dlcv_final python=3.9.21 -y
conda activate dlcv_final
```
Install the environment with pip and requirements.txt, note that the version of pytorch should match your CUDA version.
```bash 
pip install -r requirements.txt
```
```bash
accelerate config default
```
Get the dataset with
```bash
bash get_dataset.sh
```
# Training
We wrote the bash script that can train the concepts for the tasks, by simply run 
```bash
bash training_all.sh
```
The tuned parameters for the concept will be store in the specific folder assign in the .sh

# Inference
As our inference need a layout and the model need to know the specific trained embedding for the concept, we assign the json and the layout image for the prompt individualy
```bash 
bash inference_all.sh
```
When the inference information and the path to the layout image are written in the output(1~4).json
Remember to provide a pre-defined layout and a json file with the info about the details of the inference settings. The 
json file should include the following information:

- "prompt": the text prompt you want to generate.
- "residual_dict": the paths to all the required residual embeddings.
- "color_context": the color information of different regions in the layout and their corresponding subjects, along with 
the weight for strengthening the signal of target subject. (default: 2.5).
- "guidance_steps": the number of steps of the layout guidance.
- "guidance_weight": the strength of the layout guidance (default: 0.08, we recommond 0.05 ~ 0.10).
- "weight_negative": the weight for weakening the signal of irrelevant subject.
- "layout": the path to user-defined layout image.
- "subject_list": the list containing all the subjects to be customized and their corresponding positions in the prompt.
