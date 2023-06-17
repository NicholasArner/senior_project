from PIL import Image
import sys

def main():
	filename = sys.argv[1] #"../test_image4.bmp"
	im = Image.open(filename)
	pix_val = list(im.getdata())
	
	bin_img_file = open("img.bin", "wb")	
	txt_img_file = open("img.mem", "w")
	byte_data = []
	txt_data = [0]*3

	print("Writing to binary file...")
	for val in pix_val:
		#print(pix_val)
		byte_data += pix_val[0]
		byte_data += pix_val[1]
		byte_data += pix_val[2]
		txt_data[0] = val[0]
		txt_data[1] = val[1]
		txt_data[2] = val[2]
		res = ''.join(format(x, '02x') for x in txt_data)
		txt_img_file.write(res + "\n")
	
	byte_array = bytearray(byte_data)		
	bin_img_file.write(byte_array)
	#txt_img_file.write(str(byte_array))	

	im.close()
	bin_img_file.close()	
	txt_img_file.close()

	print("done")

if __name__ == '__main__':
	main()
