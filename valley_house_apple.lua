--This code starts the main loop for The Wellness Network

--Create global variables for the main loop
local currentPage = 0;
local totalPages = 0;

--Create main function for The Wellness Network
function main() 
	--Create a loop for the menu
	while(true) do
		--Ask user what page they want to go to
		print("What page would you like to go to? (0 for exit): ");
		currentPage = io.read();

		--Input validation. Make sure the input is a number
		if type(currentPage) ~= "number" then
			print("Please enter a valid page number");
			break;
		end

		--If page number is 0, exit the loop
		if currentPage == 0 then
			print("Exiting the loop...");
			break;
		end

		--Get the total pages for the program 
		totalPages = getTotalPages("The Wellness Network");

		--Validation page number
		if currentPage > totalPages then
			print("This page does not exist. Please enter a valid page number");
		else 
			--Show the appropriate page
			showPage(currentPage);
		end
	end
end

--Function to get the total number of pages 
function getTotalPages(programName) 
	local pages = 0;

	--Check what program the user is looking for
	if programName == "The Wellness Network" then
		pages = 10;
	end

	return pages;
end

--Function to show the page the user requested
function showPage(pageNumber) 
	--Check what page the user requested
	if pageNumber == 1 then 
		print("Welcome to The Wellness Network. Please choose from the following options: ");
		print("1. Exercise Regimen");
		print("2. Nutrition");
		print("3. Mental Health");
		print("4. Lifestyle");
		print("5. Resources");
		print("6. Community");
		print("7. About Us");
	elseif pageNumber == 2 then 
		print("Exercise Regimen\n");
		print("Our exercise regimen programs are designed to help you reach your goals. Whether you want to lose weight, build muscle or just stay active, our programs can help you achieve your goals.\n");
	elseif pageNumber == 3 then 
		print("Nutrition\n");
		print("Our nutrition programs are designed to provide you with the tools and information you need to maintain a healthy diet. Our programs focus on creating a balanced diet that is tailored to your individual needs.\n");
	elseif pageNumber == 4 then 
		print("Mental Health\n");
		print("Our mental health programs are designed to help you manage stress, anxiety and other negative emotions. We provide resources and support to help you lead a healthier and happier life.\n");
	elseif pageNumber == 5 then 
		print("Lifestyle\n");
		print("Our lifestyle programs focus on helping you lead a healthy and balanced life. We provide resources and support to help you make positive lifestyle changes that will benefit your overall well-being.\n");
	elseif pageNumber == 6 then 
		print("Resources\n");
		print("Our resources page provides you with access to helpful information and support. We provide links to helpful websites, articles and blogs to help you reach your goals.\n");
	elseif pageNumber == 7 then 
		print("Community\n");
		print("Our community page is designed to help you connect with other people who are striving for the same goals as you. You can join discussion forums, ask questions and exchange advice and support with other members.\n");
	elseif pageNumber == 8 then 
		print("About Us\n");
		print("The Wellness Network is a community dedicated to helping people live healthier lifestyles. We provide resources and support to help you reach your goals and lead a healthier life.\n");
	elseif pageNumber == 9 then 
		print("Contact Us\n");
		print("If you have any questions or would like to provide feedback, please contact us at info@thewellnessnetwork.com.\n");
	elseif pageNumber == 10 then 
		print("Thank you for visiting The Wellness Network.  We hope you found the information helpful. Good luck on your journey to wellness!\n");
	end
end

--Call main function
main();